import 'package:flutter/material.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:train_app/providers/presenter.dart';
import 'package:train_app/screens/screens.dart';
import 'package:train_app/preferences/preferences.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  await Preferences.init();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ThemePresenter(isDarkMode: Preferences.isDarkMode))
      ],
      child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TrainIT',
      initialRoute: 'loadScreen',
      routes: {
        'loadScreen': (_) => const LoadScreen()
      },
      home: const LoadScreen(),
      theme: Provider.of<ThemePresenter>(context).currentTheme,

    );
  }
}
