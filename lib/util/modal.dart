import 'package:flutter/material.dart';

class Modal{

  mainBottomSheet(BuildContext context, String title, String resume ){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _creatTile(context, title, resume, Icons.notifications_active, _action),
            ],
          );
        }
    );
  }

  ListTile _creatTile(BuildContext context, String title, String resume, IconData icon, Function action){
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(resume),
      onTap: (){
        Navigator.pop(context);
        action();
      }
    );
  }

  _action(){
    print("action ");
  }



}

