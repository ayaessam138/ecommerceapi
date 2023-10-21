import 'package:ecommerceapi/auth_screen/Auth_cubit/auth_cubit.dart';
import 'package:ecommerceapi/auth_screen/Register_screen.dart';
import 'package:ecommerceapi/homescrren.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/auth_background.png"),
                  fit: BoxFit.fill)),
          child: BlocConsumer<AuthCubit, AuthState>(
              builder: (BuildContext context, state) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 40),
                    child: const Text(
                      "Login to continue process",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35))),
                    child: Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ListView(
                          children: [
                            const Center(
                                child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            )),
                            TextFieldWidget(
                              controller: emailController,
                              hint: "Email",
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFieldWidget(
                              controller: passwordController,
                              obscureText: true,
                              hint: "Password",
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            // DropDownWidget(
                            //     items: const ['mo', 'ali'],
                            //     value: authCubit.chosenValue,
                            //     onChanged: (val) => authCubit
                            //         .changeDropDownValue(val: val!)),
                            SizedBox(
                              height: 25,
                            ),
                            MaterialButton(
                              height: 40,
                              elevation: 0,
                              onPressed: () {
                                if (formKey.currentState!.validate() == true) {
                                  authCubit.login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              minWidth: double.infinity,
                              color: Colors.blue,
                              textColor: Colors.white,
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    state is loginAuthloading
                                        ? "Loading..."
                                        : "Login",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.5),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Don\'t have an account? ',
                                    style: TextStyle(color: Colors.black)),
                                SizedBox(
                                  width: 4,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterScreen()));
                                  },
                                  child: const Text('Create one',
                                      style: TextStyle(
                                          color: Colors.deepOrange,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }, listener: (BuildContext context, state) {
            if (state is loginAuthSucess) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            } else if (state is loginAuthfail) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Container(
                alignment: Alignment.center,
                height: 50,
                child: Text('SomeThing wentWrong ,Please Try Again'),
              )));
            }
          })),
    );
  }
}

class DropDownWidget extends StatelessWidget {
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  const DropDownWidget(
      {Key? key, required this.items, this.value, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        items: items
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
        value: value,
        onChanged: onChanged);
  }
}

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool? obscureText;
  const TextFieldWidget(
      {Key? key,
      this.obscureText,
      required this.hint,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: (input) {
        if (controller.text.isNotEmpty) {
          return null;
        } else {
          return "$hint must not be empty";
        }
      },
    );
  }
}
