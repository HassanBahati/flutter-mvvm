import 'package:flutter/cupertino.dart';
import 'package:flutter_mvvm/models/users/user_error.dart';
import 'package:flutter_mvvm/models/users/users_list_model.dart';
import 'package:flutter_mvvm/repo/api_status.dart';
import 'package:flutter_mvvm/repo/users/user_services.dart';

class UsersViewModel extends ChangeNotifier {
  bool _loading = false;
  List<UsersModel> _userListModel = [];
  UserError _userError = UserError(code: "", message: "");

  bool get loading => _loading;
  List<UsersModel> get userListModel => _userListModel;
  UserError get userError => _userError;

  UsersViewModel(){
    getUsers();
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setUserListModel(List<UsersModel> userListModel){
    _userListModel = userListModel;
  }

  setUserError(UserError userError){
    _userError = userError;
  }

  getUsers() async{
    setLoading(true);
    var response = await UserServices.getUsers();

    if(response is Success){
      setUserListModel(response.response as List<UsersModel>);
    }

    if(response is Failure){
      UserError userError = UserError(
        code: response.code.toString(),
        message: response.errorResponse.toString()
      );
      setUserError(userError);
    }
    setLoading(false);
  }
}

