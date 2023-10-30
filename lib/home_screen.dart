import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/models/users/users_list_model.dart';
import 'package:flutter_mvvm/view_models/users/users_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    UsersViewModel usersViewModel = context.watch<UsersViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            _ui(usersViewModel)
          ],
        ),
      ),
    );
  }

  _ui(UsersViewModel usersViewModel){
    if(usersViewModel.loading){
      return Container();
    }

    if(usersViewModel.userError !=null){
      return Container();
    }

    return Expanded(child: ListView.separated(
      itemBuilder: (context, index){
        UsersModel usersModel = usersViewModel.userListModel[index];
        return Container(
          child: Column(children: [const Text("test"),Text(usersModel.name, style: TextStyle(color: Colors.black)), Text(usersModel.email)],),
        );
      },
      separatorBuilder: (context, index) => Divider(),
      itemCount: usersViewModel.userListModel.length,
    )
    );
  }


}