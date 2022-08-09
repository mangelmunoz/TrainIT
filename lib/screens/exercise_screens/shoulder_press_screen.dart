
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:train_app/screens/screens.dart';
import 'package:train_app/services/services.dart';

class ArmPressScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final int repetitions;
  final int series;
  final int restTime;
  final String parameters;
  
  // ignore: use_key_in_widget_constructors
  const ArmPressScreen({
    required this.cameras, 
    required this.repetitions,
    required this.series, 
    required this.restTime, 
    required this.parameters
  });
    
  @override
  _ArmPressScreenState createState() => _ArmPressScreenState();
}

class _ArmPressScreenState extends State<ArmPressScreen> {
  List? _data;
  int _imageHeight = 0;
  int _imageWidth = 0;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  _setRecognitions(data, imageHeight, imageWidth) {
    if (!mounted) {
      return;
    }
    setState(() {
      _data = data;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  loadModel() async {
    
    return await Tflite.loadModel(
      model: "assets/posenet_mv1_075_float_from_checkpoints.tflite"
    );
  }

  Future<bool> exitSesion() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Atención'),
          content: const Text('¿Estás seguro de que quieres salir? Si abandonas, no se guardarán los datos de la sesión.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  HomeScreen(cameras)), (Route<dynamic> route) => false
                );
              },
              child: const Text(
                'Salir',
                style: TextStyle(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ],
        );
      },
    ) ?? false; 
  }

  @override
  Widget build(BuildContext context) {

    Size screen = MediaQuery.of(context).size;
    
    return  WillPopScope(
      onWillPop: exitSesion,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Press de hombros', 
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.06, 
              color: Colors.white
            ),
          ),
          backgroundColor: const Color.fromARGB(0,0,0,0),
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => exitSesion(),
              );
            },
          ),
        ),
        body: Stack(
          children: [
            Camera(
              cameras: widget.cameras,
              setRecognitions: _setRecognitions,
            ),
            ShoulderPressPoints( data: _data,
              previewH: max(_imageHeight, _imageWidth),
              previewW: min(_imageHeight, _imageWidth),
              screenH: screen.height,
              screenW: screen.width, 
              repetitions: widget.repetitions, 
              restTime: widget.restTime, 
              series: widget.series,
              parameters: widget.parameters
            )
          ],
        ),
      )
    );
  }
}
