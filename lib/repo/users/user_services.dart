import 'dart:io';

import 'package:flutter_mvvm/models/users/users_list_model.dart';
import 'package:flutter_mvvm/repo/api_status.dart';
import 'package:flutter_mvvm/utils/constants.dart';
import 'package:http/http.dart' as http;


class UserServices {
  static Future<Object> getUsers() async{
    try{
      var url = Uri.parse(USERS_LIST);
      var response = await http.get(url);
      if (200 == response.statusCode){
        return Success(response: usersListModelFromJson(response.body as List<UsersModel>));
      }
      return Failure(code: USER_INVALID_RESPONSE, errorResponse: 'Invalid Response');
    } on HttpException{
        return Failure(code: NO_INTERNET, errorResponse: 'No Internet');
      }
      on FormatException{
        return Failure(code: INVALID_FORMAT , errorResponse: 'Invalid Format');
      }
      catch (e){
return Failure(code: UNKOWN_ERROR, errorResponse: 'Unknown error');
    }
  }
}