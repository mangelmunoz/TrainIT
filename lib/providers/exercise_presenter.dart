

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_app/models/models.dart';
import 'package:train_app/screens/screens.dart';

class ExercisePresenter{

  void loadExerciseParameters() async {

    String response = await rootBundle.loadString('assets/exercises_parameters.json');
    final data = json.decode(response);

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    localStorage.setString('arm_press_parameters', json.encode(data['arm_press']));
    localStorage.setString('squats_parameters', json.encode(data['squats']));
    localStorage.setString('curl_biceps_parameters', json.encode(data['curl_biceps']));
    
  }

    
  Future<List<Exercise>> _getExercises() async{

    List<Exercise> exercises = [];
    String response = await rootBundle.loadString('assets/exercises_info.json');

    final data = json.decode(response);

    SharedPreferences localStorage = await SharedPreferences.getInstance();

    for(var i in data.keys){

      Exercise exercise = Exercise();
     
      exercise.setName = data[i]['name']!;
      exercise.setImg = data[i]['img']!;
      exercise.setInfoimg = data[i]['info_img']!;
      exercise.setGroup = data[i]['group']!;
      exercise.setDifficulty = data[i]['dificulty'];
      exercise.setMuscles =  data[i]['muscles']!;
      exercise.setExplication =  data[i]['explication']!;
      exercise.setImages =  data[i]['images']!;
      exercise.setParameters = localStorage.getString('${data[i]['localStorage']}_parameters');

      exercises.add(exercise);

    }

    return exercises;  
  }


  FutureBuilder<dynamic> showExercises(){

    return FutureBuilder(
      future: _getExercises(),
      builder: (BuildContext context, snapshot) {    
        if (snapshot.data != null) {

          return Column(
            children: [
              GestureDetector(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExerciseScreen(),
                      settings: RouteSettings(
                        arguments: snapshot.data[0],
                      ),
                    ),
                  );
                }, 
                child: Card(
                  color: Colors.white,  
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04, 
                    right: MediaQuery.of(context).size.width * 0.04
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02, 
                          top: MediaQuery.of(context).size.width * 0.015
                        ),
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          '${snapshot.data[0].getName}', 
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.022,
                            color: Colors.black, 
                            fontWeight: FontWeight.bold 
                          ),
                        )
                      ), 
                      IconButton(
                        iconSize: MediaQuery.of(context).size.width * 0.25,
                        onPressed: () =>
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ExerciseScreen(),
                              settings: RouteSettings(
                                arguments: snapshot.data[0],
                              ),
                            ),
                          ), 
                          
                        icon: Image.asset('${snapshot.data[0].getImg}')
                      )
                    ]
                  )
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              GestureDetector(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExerciseScreen(),
                      settings: RouteSettings(
                        arguments: snapshot.data[1],
                      ),
                    ),
                  );
                }, 
                child: Card(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04, 
                    right: MediaQuery.of(context).size.width * 0.04
                  ),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02, 
                          top: MediaQuery.of(context).size.width * 0.01, 
                          bottom: MediaQuery.of(context).size.width * 0.01
                        ),
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          '${snapshot.data[1].getName}', 
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize:MediaQuery.of(context).size.height * 0.022, 
                            color: Colors.black, 
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                      IconButton(
                        iconSize: MediaQuery.of(context).size.width * 0.25,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExerciseScreen(),
                                settings: RouteSettings(
                                  arguments: snapshot.data[1],
                                ),
                              ),
                          );
                        }, 
                        icon: Image.asset('${snapshot.data[1].getImg}')
                      ),
                    ],
                  )         
                ),  
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              GestureDetector(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExerciseScreen(),
                      settings: RouteSettings(
                        arguments: snapshot.data[2],
                      ),
                    ),
                  );
                }, 
                child: Card(
                  margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04, 
                    right: MediaQuery.of(context).size.width * 0.04
                  ),
                  color: Colors.white,
                  child: 
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.02, 
                          top: MediaQuery.of(context).size.width * 0.015
                        ),
                        alignment: AlignmentDirectional.bottomStart,
                        child: Text(
                          '${snapshot.data[2].getName}', 
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize:  MediaQuery.of(context).size.height * 0.022,
                            color: Colors.black, 
                            fontWeight: FontWeight.bold 
                          ),
                        )
                      ),  
                      IconButton(
                        iconSize: MediaQuery.of(context).size.width * 0.27,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ExerciseScreen(),
                                settings: RouteSettings(
                                  arguments: snapshot.data[2],
                                ),
                              ),
                          );
                        },  
                        icon: Image.asset('${snapshot.data[2].getImg}')
                      ),
                    ]
                  )            
                )
              )
            ],
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