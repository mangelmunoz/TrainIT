

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_app/screens/screens.dart';

class SessionPresenter{


  dynamic _getInfo() async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    List<dynamic> values = [];

    values.add(localStorage.getString('user'));

    if(localStorage.getString('stadistics') != null){
      values.add(json.decode(localStorage.getString('stadistics')!).length);
    }
    else{
      values.add(0);
    }

    if(localStorage.getInt('maxRepetitions') != null){
      values.add(localStorage.getInt('maxRepetitions')!);
    }
    else{
      values.add(0);
    }

    return values;
  }

  FutureBuilder<dynamic> showInfo(Color backgroundColor) {

    return FutureBuilder(
      future: _getInfo(),
      builder: (BuildContext context, snapshot) {

        if (snapshot.data != null) {

          int totalSession = 0;
          int totalRepetitions = 0;
          
          if(snapshot.data[1] != null){
            totalSession = snapshot.data[1];
          }
        
          if(snapshot.data[2] != null){
            totalRepetitions = snapshot.data[2];
          }
          
          return  Column(
            children: [
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                child: IconButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PreferencesScreen(),
                    ),
                  ), 
                  icon: const Icon(Icons.settings),
                  iconSize: MediaQuery.of(context).size.height * 0.04,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02
                ),
                alignment: AlignmentDirectional.topCenter,
                child: CircleAvatar(
                  maxRadius: MediaQuery.of(context).size.height * 0.13,
                  backgroundImage: const AssetImage('images/icon-avatar.jpg'),
                  backgroundColor: Colors.white,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02
                ),
                alignment: AlignmentDirectional.topCenter,
                child: Container(
                  child: Text(
                    '${snapshot.data[0]}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                    ), 
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05), 
              Container(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: backgroundColor,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02
                            ),
                            alignment: AlignmentDirectional.topStart,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.429,
                              child: Center(
                                child: Text(
                                  'Sesiones totales', 
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.04, 
                                    fontWeight: FontWeight.w500
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01, 
                              left: MediaQuery.of(context).size.width * 0.02
                            ),
                            child:  SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Center(
                                child: Text(
                                  '$totalSession', 
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.08, 
                                    fontWeight: FontWeight.w500
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ), 
                              ),
                            ),
                            ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        ],
                      ),
                    ),
                    Card(
                      color: backgroundColor,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02
                            ),
                            alignment: AlignmentDirectional.topStart,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.429,
                              child: Center(
                                child: Text(
                                  'Nº reps. máx', 
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.04, 
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01
                            ),
                            child:  SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Center(
                                child: Text(
                                  '$totalRepetitions', 
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.08, 
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              ElevatedButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red
                ),
                child: SizedBox(
                  width:  MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                    child: Text(
                      'Ver estadísticas',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04, 
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  )
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StadisticScreen(),
                    ),
                  );
                }, 
              )
            ]
          );
        } 
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

}