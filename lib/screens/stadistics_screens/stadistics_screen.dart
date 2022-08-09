
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/screens/screens.dart';

class StadisticScreen extends StatefulWidget {
  const StadisticScreen({Key? key}) : super(key: key);

  @override
  State<StadisticScreen> createState() => _StadisticScreenState();
}

class _StadisticScreenState extends State<StadisticScreen> {

  late Color backgroundColor = const Color.fromARGB(255, 210, 239, 249);
  late Color iconColor = Colors.black;
  late dynamic stadistics;
  @override
  void initState() {

    if(Preferences.isDarkMode){
      backgroundColor =  const Color.fromARGB(255, 58, 68, 72);
      iconColor = Colors.white;
    }

    super.initState();
    stadistics =_showInfo(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TrainIT',
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
                    builder: (context) => const ProfileScreen()
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
      body: Column(
        children: [
          stadistics,
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.035
            ),
            child: Text(
              "Mejor sesión de entrenamiento", 
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.width * 0.058,
              ),  
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.034, 
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
                            'Nombre del ejercicio:', 
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
                  _showBestSession()
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.red
            ),
            child: SizedBox(
              width:  MediaQuery.of(context).size.width * 0.83,
              height: MediaQuery.of(context).size.height * 0.05,
              child: Center(
                child: Text(
                  'Ver estadísticas por ejercicio', 
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04, 
                    fontWeight: FontWeight.w500,
                  )
                )
              )
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExerciseStadisticsScreen(),
                ),
              );
            }, 
          )
        ],
      )
    );
  }

  dynamic _getInfo(date) async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    List<dynamic> values = [];

    values.add(localStorage.getString('user'));
    DateTime dateCompare = DateTime.now().subtract(const Duration(days: 7));
    if(date == 2){
      dateCompare = DateTime.now().subtract(const Duration(days: 30));
    }
    else if(date == 3){
      dateCompare = DateTime.now().subtract(const Duration(days: 365));
    }
    int counter = 0;
    int maxRepetitions = 0;
    
    if(localStorage.getString('stadistics') != null){
      
      dynamic stadistics = json.decode(localStorage.getString('stadistics')!);
      for(dynamic i in stadistics.keys){
        
        DateTime sesionDate = DateTime.parse(stadistics[i]['date']);

        if(sesionDate.isAfter(dateCompare)){
          counter++;
          
          if(maxRepetitions < stadistics[i]['repetitions']){
            maxRepetitions = stadistics[i]['repetitions'];
          }
        }
      }
    }

    values.add(counter);
    values.add(maxRepetitions);    
    
    return values;
  }

  FutureBuilder<dynamic> _showInfo(value) {

    return FutureBuilder(
      future: _getInfo(value),
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
          
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.03
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.07
                  ),
                  alignment: AlignmentDirectional.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Estadísticas", 
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width * 0.09,
                        ),  
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left:  MediaQuery.of(context).size.width * 0.045
                        ),
                        alignment: AlignmentDirectional.center,
                        width: MediaQuery.of(context).size.width * 0.35,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: DropdownButtonFormField<int>(
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
                          value: 1,
                          items: const [
                            DropdownMenuItem( value: 1, child: Text('Semana')),
                            DropdownMenuItem( value: 2, child: Text('Mes')),
                            DropdownMenuItem( value: 3, child: Text('Año')),
                          ],
                          menuMaxHeight: 200, 
                          onChanged: (value){
                            setState(() {
                             stadistics = _showInfo(value);
                            });
                          }, 
                        ),
                      ),
                    ],
                  )
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05), 
                Container(
                  alignment: AlignmentDirectional.centerStart,
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
                                width: MediaQuery.of(context).size.width * 0.46,
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
                                width: MediaQuery.of(context).size.width * 0.35,
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
                                width: MediaQuery.of(context).size.width * 0.4,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              ]
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

  dynamic _getBestSession() async{

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    dynamic values = {};

    if(localStorage.getString('bestSession') != null){
      values = json.decode(localStorage.getString('bestSession')!);
    }
    else{

      values['exercise_name'] = '-';
      values['repetitions'] = 0;
      values['series'] = 0;
      values['restTime'] = 0;
    }

    return values;
  }

 FutureBuilder<dynamic> _showBestSession() {

    return FutureBuilder(
      future: _getBestSession(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data != null) {

          String name = '-';
          int repetitions = 0;
          int series = 0;
          int restTime = 0;

          if(snapshot.data['exercise_name'] != null){
            name = snapshot.data['exercise_name'];
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
              top: MediaQuery.of(context).size.height * 0.03, 
              left: MediaQuery.of(context).size.width * 0.05
            ),
            alignment: AlignmentDirectional.centerEnd,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Center(
                    child: Text(
                      name, 
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
                  width: MediaQuery.of(context).size.width * 0.42,
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
                  width: MediaQuery.of(context).size.width * 0.42,
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
                  width: MediaQuery.of(context).size.width * 0.42,
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

}