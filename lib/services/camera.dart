import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef Callback = void Function(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;

  // ignore: use_key_in_widget_constructors
  const Camera({required this.cameras, required this.setRecognitions});

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  late CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {

    if (widget.cameras.isEmpty) {
      print('No camera is found');
    } else {

      controller = CameraController(
        widget.cameras[1],
        ResolutionPreset.high,
      );
      
      controller.initialize().then((_) {

        if (!mounted) {
          return;
        }

        setState(() {});

        controller.startImageStream((CameraImage img) {

          if (!isDetecting) {
            isDetecting = true;

            Tflite.runPoseNetOnFrame(

              bytesList: img.planes.map((plane) {
                return plane.bytes;
              }).toList(),
              imageHeight: img.height,
              imageWidth: img.width,
              numResults: 1,
              rotation: -90,
              threshold: 0.1,
              nmsRadius: 10,
            ).then((recognitions) {

              widget.setRecognitions(recognitions!, img.height, img.width);
              isDetecting = false;

            });
          }
        });
      });
    }
    
    super.initState();

  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    Size? tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.max(tmp!.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return OverflowBox(
      maxHeight:
          screenRatio > previewRatio ? screenH : screenW / previewW * previewH,
      maxWidth:
          screenRatio > previewRatio ? screenH / previewH * previewW : screenW,
      child: CameraPreview(controller),
    );
  }
}
