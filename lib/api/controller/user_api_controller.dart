import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tokoto/api/api_settings.dart';

class UserApiController {
  // Future<bool> login({
  //   required bool rememberMe,
  //   required String email,
  //   required String password,
  // }) async {
  //   var url = Uri.parse(ApiSettings.LOGIN);
  //   var response = await http.post(url, body: {
  //     'email': email,
  //     'password': password,
  //   });
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     var jsonArray = jsonResponse;
  //     UserModel user = UserModel.fromJson(jsonArray);
  //     // UserPreferencesController().saveUser(user: user, rememberMe: rememberMe);
  //     return true;
  //   } else if (response.statusCode == 401) {
  //     //
  //   }
  //   return false;
  // }

  Future<bool> register({
    required String id,
    required String fName,
    required String lName,
    required String email,
    required String password,
    required String confirmPassword,
    required String address,
    required String phone,
  }) async {
    var url = Uri.parse(ApiSettings.REGISTER);
    var response = await http.post(url, body: {
      'id': id,
      'fName': fName,
      'lName': lName,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'address': address,
      'phone': phone,
    }, headers: {
      HttpHeaders.acceptHeader: "application/json",
    });
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  // Future<bool> logout() async {
  //   var url = Uri.parse(ApiSettings.LOGOUT);
  //   var response = await http.post(url);
  //   if (response.statusCode == 200 || response.statusCode == 401) {
  //     await UserPreferencesController().logout();
  //     return true;
  //   }
  //   return false;
  // }
}
