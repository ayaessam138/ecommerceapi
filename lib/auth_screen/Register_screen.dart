import 'package:ecommerceapi/auth_screen/Auth_cubit/auth_cubit.dart';
import 'package:ecommerceapi/homescrren.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController Name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController Phone = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterAuthSucess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        } else if (state is RegisterAuthfail) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.ErrorMeesage,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Colors.white),
                  )));
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(
                  height: 20,
                ),
                textFormItem(controller: Name, hintTitle: 'Name'),
                const SizedBox(
                  height: 20,
                ),
                textFormItem(controller: email, hintTitle: 'Email'),
                const SizedBox(
                  height: 20,
                ),
                textFormItem(controller: password, hintTitle: 'Password'),
                const SizedBox(
                  height: 20,
                ),
                textFormItem(controller: Phone, hintTitle: 'Phone'),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      BlocProvider.of<AuthCubit>(context).Register(
                          name: Name.text,
                          email: email.text,
                          Phone: Phone.text,
                          password: password.text);
                    } else {}
                  },
                  child: Text(
                    'Register',
                    style:
                        TextStyle(fontSize: 16.5, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 12.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ));
      },
    );
  }
}

Widget textFormItem(
    {required String hintTitle, required TextEditingController controller}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        hintText: hintTitle, border: const OutlineInputBorder()),
    validator: (input) {
      if (controller.text.isNotEmpty) {
        return null;
      } else {
        return "$hintTitle must not be empty!";
      }
    },
  );
}
