import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:wakelock/wakelock.dart';

import 'package:train_app/models/session.dart';
import 'package:train_app/screens/screens.dart';


class SquatPoints extends StatefulWidget {

  final String parameters;
  final List? data;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final int repetitions;
  final int series;
  final int restTime;

  const SquatPoints(
    {Key? key,
    required this.parameters,
    required this.data, 
    required this.previewH, 
    required this.previewW,
    required this.screenH, 
    required this.screenW, 
    required this.repetitions, 
    required this.series, 
    required this.restTime}) 
    : super(key: key);

  @override
  State<SquatPoints> createState() => _SquatPointsState();
}

class _SquatPointsState extends State<SquatPoints> {

  late Map<String, List<double>> points;
  late bool bodyPosition;
  late bool initialState;
  late bool changeState;
  late bool restTimeState;
  late bool finished;
  late bool repetitionComplete;
  late int repetitionsCounter;
  late int seriesCounter;
  late String state;
  late final Map<String, dynamic> parameters;

  @override
  void initState() {
    points = {};
    bodyPosition = false;
    initialState = false; 
    changeState = false;
    restTimeState = false;
    finished = false;
    repetitionComplete = false;
    repetitionsCounter = 0;
    seriesCounter = 0;
    state = 'Colócate en posición';
    parameters = jsonDecode(widget.parameters);

    Wakelock.enable();
    super.initState();
  }

  void playRepetitionSound() {
    
    AudioCache player = AudioCache(); 
    player.play('repetition.mp3');
  
  }

  void playSeriesSound() {
    
    AudioCache player = AudioCache(); 
    player.play('serie.mp3');
  
  }

  void playSesionSound() {
    
    AudioCache player = AudioCache(); 
    player.play('sesion.mp3');
  
  }

  Future<void> safeSessionInfo() async {

    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Map<dynamic,dynamic> sessionsStorage = {};
    Session sesion = Session();

    sesion.setDate =  DateTime.now().toIso8601String();
    sesion.setExerciseName = 'Sentadillas';
    sesion.setRepetitions = widget.repetitions;
    sesion.setSeries = widget.series;
    sesion.setRestTime = widget.restTime;
    
    if(localStorage.getString('stadistics') != null){
      sessionsStorage = json.decode(localStorage.getString('stadistics')!);
      sessionsStorage["${sessionsStorage.length}"] = sesion.toJson();

      localStorage.setString('stadistics', json.encode(sessionsStorage));
    }
    else{
      sessionsStorage["0"] =  sesion.toJson();
      localStorage.setString('stadistics', json.encode(sessionsStorage));
    }

    Map<dynamic,dynamic> bestSession = sessionsStorage["0"];
    int maxRepetitions = sessionsStorage["0"]['repetitions'];
    
    for(dynamic i in sessionsStorage.keys){
      
      int bestTotalSesionRepetitions = (bestSession['repetitions'] * bestSession['series']);
      int iteratorTotalSessionRepetitions = (sessionsStorage[i]['repetitions'] * sessionsStorage[i]['series']);

      if( bestTotalSesionRepetitions <= iteratorTotalSessionRepetitions){
          bestSession = sessionsStorage[i];
      }

      if(bestSession['repetitions'] <= sessionsStorage[i]['repetitions']){
        maxRepetitions = sessionsStorage[i]['repetitions'];
      }

    }

    localStorage.setString('bestSession', json.encode(bestSession));
    localStorage.setInt('maxRepetitions', maxRepetitions);

  }

  void _checkPointsDistance(Map<String, List<double>> pointsResult) {

    double xvalue = pow((pointsResult['leftShoulder']![0] - pointsResult["leftAnkle"]![0]), 2) as double;
    double  yvalue = pow((pointsResult['leftShoulder']![1] - pointsResult["leftAnkle"]![1]), 2) as double;
    
    double leftShoulderAnkle = sqrt( xvalue + yvalue);

    xvalue = pow((pointsResult['rightShoulder']![0] - pointsResult["rightAnkle"]![0]), 2) as double;
    yvalue = pow((pointsResult['rightShoulder']![1] - pointsResult["rightAnkle"]![1]), 2) as double;
    
    double rightShoulderAnkle = sqrt( xvalue + yvalue);

    xvalue = pow((pointsResult['leftShoulder']![0] - pointsResult["leftKnee"]![0]), 2) as double;
    yvalue = pow((pointsResult['leftShoulder']![1] - pointsResult["leftKnee"]![1]), 2) as double;
    
    double leftShoulderKnee = sqrt( xvalue + yvalue);

    xvalue = pow((pointsResult['rightShoulder']![0] - pointsResult["rightKnee"]![0]), 2) as double;
    yvalue = pow((pointsResult['rightShoulder']![1] - pointsResult["rightKnee"]![1]), 2) as double;
    
    double rightShoulderKnee = sqrt( xvalue + yvalue);

    xvalue = pow((pointsResult['leftHip']![0] - pointsResult["leftKnee"]![0]), 2) as double;
    yvalue = pow((pointsResult['leftHip']![1] - pointsResult["leftKnee"]![1]), 2) as double;
    
    double leftHipKnee = sqrt( xvalue + yvalue);
    
    xvalue = pow((pointsResult['rightHip']![0] - pointsResult["rightKnee"]![0]), 2) as double;
    yvalue = pow((pointsResult['rightHip']![1] - pointsResult["rightKnee"]![1]), 2) as double;
    
    double rightHipKnee = sqrt( xvalue + yvalue);

    xvalue = pow((pointsResult['leftHip']![0] - pointsResult["leftAnkle"]![0]), 2) as double;
    yvalue = pow((pointsResult['leftHip']![1] - pointsResult["leftAnkle"]![1]), 2) as double;
    
    double leftHipAnkle  = sqrt( xvalue + yvalue);

    xvalue = pow((pointsResult['rightHip']![0] - pointsResult["rightAnkle"]![0]), 2) as double;
    yvalue = pow((pointsResult['rightHip']![1] - pointsResult["rightAnkle"]![1]), 2) as double;
    
    double rightHipAnkle = sqrt( xvalue + yvalue);
    
    xvalue = pow((pointsResult['leftKnee']![0] - pointsResult["leftAnkle"]![0]), 2) as double;
    yvalue = pow((pointsResult['leftKnee']![1] - pointsResult["leftAnkle"]![1]), 2) as double;
    
    double leftKneeAnkle  = sqrt( xvalue + yvalue);
    
    xvalue = pow((pointsResult['rightKnee']![0] - pointsResult["rightAnkle"]![0]), 2) as double;
    yvalue = pow((pointsResult['rightKnee']![1] - pointsResult["rightAnkle"]![1]), 2) as double;
    
    double rightKneeAnkle = sqrt( xvalue + yvalue);

    if( !restTimeState &&
        !finished &&
        !bodyPosition &&
        ( rightShoulderAnkle >= parameters['body_position']['shoulder-ankle'][0] && 
          rightShoulderAnkle <= parameters['body_position']['shoulder-ankle'][1] &&
          leftShoulderAnkle >= parameters['body_position']['shoulder-ankle'][0] && 
          leftShoulderAnkle <= parameters['body_position']['shoulder-ankle'][1])
    ){

      bodyPosition = true;
      
      setState(() {
        state = 'Cuerpo en posición';  
      });   

    }
      
    if( !restTimeState &&
        !finished &&
        bodyPosition &&
        !initialState && 
        !changeState &&
        ( leftShoulderKnee  >= parameters['initial_state']['shoulder-knee'][0] && 
          leftShoulderKnee  <= parameters['initial_state']['shoulder-knee'][1] &&
          rightShoulderKnee >= parameters['initial_state']['shoulder-knee'][0] && 
          rightShoulderKnee <= parameters['initial_state']['shoulder-knee'][1]
        ) 
        &&
        ( leftHipAnkle  >= parameters['initial_state']['hip-ankle'][0] && 
          leftHipAnkle  <= parameters['initial_state']['hip-ankle'][1] &&
          rightHipAnkle >= parameters['initial_state']['hip-ankle'][0] && 
          rightHipAnkle <= parameters['initial_state']['hip-ankle'][1]
        ) &&
        ( leftHipKnee  >= parameters['initial_state']['hip-knee'][0] && 
          leftHipKnee  <= parameters['initial_state']['hip-knee'][1] &&
          rightHipKnee >= parameters['initial_state']['hip-knee'][0] && 
          rightHipKnee <= parameters['initial_state']['hip-knee'][1]
        )
        &&
        ( leftKneeAnkle  >= parameters['initial_state']['knee-ankle'][0] && 
          leftKneeAnkle  <= parameters['initial_state']['knee-ankle'][1] &&
          rightKneeAnkle >= parameters['initial_state']['knee-ankle'][0] && 
          rightKneeAnkle <= parameters['initial_state']['knee-ankle'][1]
        )
    ){
      repetitionComplete = false;
      initialState = true;
      setState(() {
        state = 'Baja la cadera';  
      });
    }

    if( !restTimeState &&
        !finished &&
        bodyPosition &&
        initialState && 
        !changeState &&
        ( leftShoulderKnee >= parameters['hip_down']['shoulder-knee'][0] && 
          leftShoulderKnee <= parameters['hip_down']['shoulder-knee'][1] &&
          rightShoulderKnee >= parameters['hip_down']['shoulder-knee'][0] && 
          rightShoulderKnee <= parameters['hip_down']['shoulder-knee'][1]
        ) 
        &&
        ( leftHipAnkle >= parameters['hip_down']['hip-ankle'][0] && 
          leftHipAnkle <= parameters['hip_down']['hip-ankle'][1] &&
          rightHipAnkle >= parameters['hip_down']['hip-ankle'][0] && 
          rightHipAnkle <= parameters['hip_down']['hip-ankle'][1]
        ) &&
        ( leftHipKnee >= parameters['hip_down']['hip-knee'][0] && 
          leftHipKnee <= parameters['hip_down']['hip-knee'][1] &&
          rightHipKnee >= parameters['hip_down']['hip-knee'][0] && 
          rightHipKnee <= parameters['hip_down']['hip-knee'][1]
        )
        &&
        ( leftKneeAnkle >= parameters['hip_down']['knee-ankle'][0] && 
          leftKneeAnkle <= parameters['hip_down']['knee-ankle'][1] &&
          rightKneeAnkle >= parameters['hip_down']['knee-ankle'][0] && 
          rightKneeAnkle <= parameters['hip_down']['knee-ankle'][1]
        )
    ){
      initialState = false;
      changeState = true;
      setState(() {
        state = 'Sube la cadera';  
      });
    }

    if( !restTimeState &&
        !finished &&
        bodyPosition &&
        !initialState && 
        changeState &&
        ( leftShoulderKnee >= parameters['initial_state']['shoulder-knee'][0] && 
          leftShoulderKnee <= parameters['initial_state']['shoulder-knee'][1] &&
          rightShoulderKnee >= parameters['initial_state']['shoulder-knee'][0] && 
          rightShoulderKnee <= parameters['initial_state']['shoulder-knee'][1]
        ) 
        &&
        ( leftHipAnkle >= parameters['initial_state']['hip-ankle'][0] && 
          leftHipAnkle <= parameters['initial_state']['hip-ankle'][1] &&
          rightHipAnkle >= parameters['initial_state']['hip-ankle'][0] && 
          rightHipAnkle <= parameters['initial_state']['hip-ankle'][1]
        ) &&
        ( leftHipKnee >= parameters['initial_state']['hip-knee'][0] && 
          leftHipKnee <= parameters['initial_state']['hip-knee'][1] &&
          rightHipKnee >= parameters['initial_state']['hip-knee'][0] && 
          rightHipKnee <= parameters['initial_state']['hip-knee'][1]
        )
        &&
        ( leftKneeAnkle >= parameters['initial_state']['knee-ankle'][0] && 
          leftKneeAnkle <= parameters['initial_state']['knee-ankle'][1] &&
          rightKneeAnkle >= parameters['initial_state']['knee-ankle'][0] && 
          rightKneeAnkle <= parameters['initial_state']['knee-ankle'][1]
        )
    ){
      changeState = false;
      setState(() {

        repetitionsCounter++;
        state = 'OK';

        if(repetitionsCounter == widget.repetitions){
          playSeriesSound();
          seriesCounter++;

          restTimeState = true;
          int difRestTime = widget.restTime;

          if(seriesCounter == widget.series){
            playSesionSound();
            finished = true;

            Wakelock.disable();
            safeSessionInfo();

            state = 'Entreno finalizado';
            Timer(Duration(seconds: 3), () {
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
               HomeScreen(cameras)), (Route<dynamic> route) => false);
            });
          }
          else{
            playRepetitionSound();
            repetitionsCounter = 0;

            Timer.periodic(
              const Duration(seconds: 1),
              (Timer timer) => {
                  setState(() {
                    if (difRestTime < 1) {
                      state = 'Fin de descanso';
                      restTimeState = false;
                      timer.cancel();
                    } 
                    else {
                      state = 'Nueva serie en $difRestTime';
                      difRestTime = difRestTime - 1;
                    }
                  })
                }
            );
          }
        }
        else{
          playRepetitionSound();
        }
      });
    }  
  }


  void _renderKeypoints() {
    widget.data?.forEach((re) {
      re["keypoints"].values.map((k) {
        var _x = k["x"];
        var _y = k["y"];
        double scaleW, scaleH;
        double x, y;

        if( widget.screenH / widget.screenW > widget.previewH / widget.previewW ) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          y = (_x - difW / 2) * scaleW;
          x = _y * scaleH;
        } 
        else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          y = _x * scaleH;
          x = (_y - difH / 2) * scaleW;
        }
        points[k['part']] = [x, y];
          
          //Mirroring
        if (x > 320) {
          var temp = 320 - x;
          x = 320 + temp;
        } else {
          var temp = x - 320;
          x = 320 - temp;
        }

        }).toList();
        
        _checkPointsDistance(points);

        points.clear();

      });
  }

  @override
  Widget build(BuildContext context) {

    _renderKeypoints();

    return Stack(
      children: [
        Container(
          alignment: AlignmentDirectional.center,
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.03, 
            top: MediaQuery.of(context).size.height * 0.72
          ),
          width:  MediaQuery.of(context).size.width * 0.65,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Card(
            color: const Color.fromARGB(255, 138, 138, 138),
            shadowColor: Colors.grey,
            child: Text(
              state,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1, 
                fontWeight: FontWeight.bold, 
                color: Colors.white, 
                fontFamily: 'Console'
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.35, 
            right: MediaQuery.of(context).size.width * 0.035
          ),
          child: Column(
            children: [
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.65, 
                  top: MediaQuery.of(context).size.height * 0.3
                ),
                width: MediaQuery.of(context).size.width * 0.255,
                height: MediaQuery.of(context).size.height * 0.14,
                child: Text(
                  ' ${seriesCounter.toString()}/${widget.series.toString()} ',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white
                  ),
                ),
              ),
              Container(
                alignment: AlignmentDirectional.bottomEnd,
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.55
                ),
                width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Text(
                  ' ${repetitionsCounter.toString()}/${widget.repetitions.toString()} ',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.14, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.white
                  ),
                ),
              ),
            ],
          ),
        )
      ]
    );
  }
}