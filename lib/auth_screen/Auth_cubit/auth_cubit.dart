import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  void Register(
      {required String name,
      required String email,
      required String Phone,
      required String password}) async {
    emit(RegisterAuthloading());
    Response response = await http
        .post(Uri.parse('https://student.valuxapps.com/api/register'), body: {
      'name': name,
      'email': email,
      'phone': Phone,
      'password': password,
    }, headers: {
      'lang': 'en'
    });
    var responsebody = jsonDecode(response.body);
    if (responsebody['status'] == true) {
      emit(RegisterAuthSucess());
    } else {
      emit(RegisterAuthfail(ErrorMeesage: responsebody['message']));
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    try {
      emit(loginAuthloading());
      Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/login'),
        body: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == true) {
          emit(loginAuthSucess());
        } else {
          emit(loginAuthfail());
        }
      }
    } on Exception catch (e) {
      emit(loginAuthfail());
    }
  }
}
