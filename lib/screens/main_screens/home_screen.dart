import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:train_app/models/exercise.dart';
import 'package:train_app/models/models.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/providers/presenter.dart';

import 'package:train_app/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

   // ignore: use_key_in_widget_constructors
   const HomeScreen(this.cameras);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  late Color color = const Color.fromARGB(255, 206, 1, 1);
  late Color iconColor =  Colors.black;
  late List<Exercise> exercises;

  late UserPresenter userPresenter = UserPresenter();
  late ExercisePresenter exercisePresenter = ExercisePresenter();


  @override
  void initState() {

    if(Preferences.isDarkMode){
      color = Colors.grey[800]!;
      iconColor = Colors.white;
    }
    
    exercisePresenter.loadExerciseParameters();
    super.initState();
  }
  
  void _changeView(int index) {

    setState(() {
      _selectedIndex = index;
    });

    if(index == 1){
      Navigator.pushReplacement(
        context,  
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
          transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        )
      ); 
    }    
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
        elevation:  MediaQuery.of(context).size.height * 0.01,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: color,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          const SizedBox(height: 50),
          userPresenter.showUserName(),
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              left: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.02
            ),
            child: Text(
              'Seleccione un ejercicio',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).size.height * 0.03,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.025),
          exercisePresenter.showExercises(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false, 
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.house),
            label: ''
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.person),
            label: ''
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: iconColor,
        selectedItemColor: const Color(0xFFFE7C7C),
        iconSize: MediaQuery.of(context).size.height * 0.04,
        elevation: 25.0,
        onTap: _changeView,
      ),

    );
  }
}



