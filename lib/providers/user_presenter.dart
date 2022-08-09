import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPresenter{

    Future<String> _getUserName() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    
    late String value;
    value = localStorage.getString('user') ?? '';

    return value;
  }
  
    FutureBuilder<dynamic> showUserName() {

    return FutureBuilder(
      future: _getUserName(),
      builder: (BuildContext context, snapshot) {
        
        if (snapshot.data != null) {
          
          return Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.height * 0.02, 
              right: MediaQuery.of(context).size.width * 0.02
            ),
            child: Text(
              'Bienvenido/a, ${snapshot.data}',
              style: TextStyle(
                color: const Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height * 0.035,
              ),
            ),
          );
        } 
        else {
          return  const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}