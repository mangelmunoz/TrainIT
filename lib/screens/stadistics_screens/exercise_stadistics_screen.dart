
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/screens/screens.dart';

class ExerciseStadisticsScreen extends StatefulWidget {
  
  const ExerciseStadisticsScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseStadisticsScreen> createState() => _ExerciseStadisticsScreenState();
}

class _ExerciseStadisticsScreenState extends State<ExerciseStadisticsScreen> {

  late Color backgroundColor = const Color.fromARGB(255, 210, 239, 249);
  late Color iconColor = Colors.black;
  late dynamic bestExercise = Container();
  late dynamic historyExercise = Container(); 
  
  @override
  void initState() {

    if(Preferences.isDarkMode){
      backgroundColor =  const Color.fromARGB(255, 58, 68, 72);
      iconColor = Colors.white;
    }
    bestExercise = _showBestSession('Sentadillas');
    historyExercise = _showHistorySession('Sentadillas');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('TrainIT',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MediaQuery.of(context).size.height * 0.04,
            fontFamily: 'Title Font'     
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        elevation: MediaQuery.of(context).size.height * 0.01,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacement(
                  context,  
                  MaterialPageRoute(
                    builder: (context) => const StadisticScreen()
                  )
                );
              }             
            );
          },
        ),
        iconTheme: IconThemeData(
          color: iconColor, //change your color here
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.height * 0.03, 
          vertical: MediaQuery.of(context).size.width * 0.05
        ),
        child: Column(
          children: [
            DropdownButtonFormField<String>(               
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
              ),
              disabledHint: const Text("Can't select"),
              value: 'Sentadillas',
              items: const [
                DropdownMenuItem( value: 'Sentadillas', child: Text('Sentadillas')),
                DropdownMenuItem( value: 'Press de hombros', child: Text('Press de hombros')),
                DropdownMenuItem( value: 'Curl de bíceps', child: Text('Curl de bíceps')),  
              ],
              menuMaxHeight: 200, 
              onChanged: (value){
                setState(() {
                  bestExercise = _showBestSession(value);
                  historyExercise = _showHistorySession(value);
                });
              }, 
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.035
              ),
              child: Text(
                "Mejor sesión de entrenamiento", 
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),  
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015
              ),
              child: Card(
                color: backgroundColor,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02, 
                        left: MediaQuery.of(context).size.width * 0.02
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Text(
                              'Fecha:', 
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038, 
                                fontWeight: FontWeight.w500,
                                // color: Colors.black
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Text(
                              'Número de repeticiones:', 
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038, 
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Text(
                              'Número de series:', 
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038, 
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.42,
                            child: Text(
                              'Tiempo de descanso:', 
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.038, 
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        ],
                      ),
                    ),
                    bestExercise,
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.015
              ),
              child: Text(
                "Historial", 
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                ),  
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: historyExercise
            )   
          ],
        ),
      )
    );
  }

  dynamic _getBestSession(exercise) async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    dynamic values = {};
    Map<dynamic,dynamic> bestSession = {};

    if(localStorage.getString('stadistics') != null){

      values = json.decode(localStorage.getString('stadistics')!);

      bestSession['date'] = '0000-00-00';
      bestSession['repetitions'] = 0;
      bestSession['series'] = 0;
      bestSession['restTime'] = 0;
    
      for(dynamic i in values.keys){

        if(values[i]['exercise_name'] != exercise){
          continue;
        }
        
        int bestTotalSesionRepetitions = (bestSession['repetitions'] * bestSession['series']);
        int iteratorTotalSessionRepetitions = (values[i]['repetitions'] * values[i]['series']);

        if( bestTotalSesionRepetitions <= iteratorTotalSessionRepetitions){
            bestSession = values[i];
        }

      }

      return bestSession;

    }
    else{

      bestSession['exercise_name'] = '-';
      bestSession['repetitions'] = 0;
      bestSession['series'] = 0;
      bestSession['restTime'] = 0;

      return bestSession;

    } 
  }

  FutureBuilder<dynamic> _showBestSession(exercise) {
    return FutureBuilder(
      future: _getBestSession(exercise),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data != null) {

          String date = '-';
          int repetitions = 0;
          int series = 0;
          int restTime = 0;

          if(snapshot.data['date'] != null && snapshot.data['date'] != '0000-00-00'){
            date = DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data['date'].split('T')[0]));
          }
          if(snapshot.data['repetitions'] != null){
            repetitions = snapshot.data['repetitions'];
          }
          if(snapshot.data['series'] != null){
            series = snapshot.data['series'];
          }
          if(snapshot.data['restTime'] != null){
            restTime = snapshot.data['restTime'];
          }

          return  Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.03
            ),
            alignment: AlignmentDirectional.centerEnd,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.41,
                  child: Center(
                    child: Text(
                      date, 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.41,
                  height: MediaQuery.of(context).size.width * 0.07,
                  child: Center(
                    child: Text(
                      '$repetitions', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.41,
                  height: MediaQuery.of(context).size.width * 0.07,
                  child: Center(
                    child: Text(
                      '$series', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.41,
                  height: MediaQuery.of(context).size.width * 0.06,
                  child: Center(
                    child: Text(
                      '$restTime', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ],
            ),
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

  dynamic _getHistorySession(exercise) async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    dynamic values = {};
    Map<dynamic,dynamic> logSession = {};
    dynamic history = [];

    if(localStorage.getString('stadistics') != null){

      values = json.decode(localStorage.getString('stadistics')!);

      logSession['date'] = '0000-00-00T00000000';
      logSession['repetitions'] = 0;
      logSession['series'] = 0;
      logSession['restTime'] = 0;

      for(dynamic i in values.keys){

        if(values[i]['exercise_name'] != exercise){
          continue;
        }
        
        history.add(values[i]);

      }

      if(history.length == 0){
        history.add(logSession);
      }

      return history;
    }
    else{

      logSession['date'] = '0000-00-00T00000000';
      logSession['repetitions'] = 0;
      logSession['series'] = 0;
      logSession['restTime'] = 0;

      history.add(logSession);
      
      return history;
    }
  
  }

  FutureBuilder<dynamic> _showHistorySession(exercise) {
    return FutureBuilder(
      future: _getHistorySession(exercise),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data != null) {

          return ListView(
            children: [
              for(dynamic element in snapshot.data) 
                _histoySesion(
                  element['date'].split('T')[0], 
                  element['repetitions'], 
                  element['series'], 
                  element['restTime']
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

  dynamic _histoySesion(String date, int repetitions, int series, int restTime){

    dynamic dateformat = '00-00-0000';

    if(date != '0000-00-00'){
      dateformat =  DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    }

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.005
      ),
      child: Card(
        color: backgroundColor,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02, 
                left: MediaQuery.of(context).size.width * 0.02
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: Text(
                      'Fecha:', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.038, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: Text(
                      'Número de repeticiones:', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.038, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: Text(
                      'Número de series:', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.038, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.42,
                    child: Text(
                      'Tiempo de descanso:', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.038, 
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.03
              ),
              alignment: AlignmentDirectional.centerEnd,
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.41,
                    child: Center(
                      child: Text(
                        dateformat, 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.045, 
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.41,
                    height: MediaQuery.of(context).size.width * 0.07,
                    child: Center(
                      child: Text(
                        '$repetitions', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05, 
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.41,
                    height: MediaQuery.of(context).size.width * 0.07,
                    child: Center(
                      child: Text(
                        '$series', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05, 
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.41,
                    height: MediaQuery.of(context).size.width * 0.06,
                    child: Center(
                      child: Text(
                        '$restTime', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05, 
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
    );           
  }
}

