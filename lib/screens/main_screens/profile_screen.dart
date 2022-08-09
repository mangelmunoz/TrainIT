import 'package:flutter/material.dart';

import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/providers/presenter.dart';
import 'package:train_app/screens/screens.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int _selectedIndex = 1;
  late Color color = const Color.fromARGB(255, 206, 1, 1);
  late Color iconColor = Colors.black;
  late Color backgroundColor =const Color.fromARGB(255, 210, 239, 249);

  @override
  void initState() {

    if(Preferences.isDarkMode){
      color = Colors.grey[800]!;
      iconColor = Colors.white;
      backgroundColor =  const Color.fromARGB(255, 58, 68, 72);
    }
   
    super.initState();
  }

  
  void _changeView(int index) {

    setState(() {
      _selectedIndex = index;
    });

    if(_selectedIndex == 0){
      Navigator.pushReplacement(
        context,  
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(cameras),
          transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
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

    SessionPresenter sessionPresenter = SessionPresenter();
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
      ),
      body:  sessionPresenter.showInfo(backgroundColor),
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
        iconSize:  MediaQuery.of(context).size.height * 0.04,
        elevation: 25.0,
        onTap: _changeView,
      ),

    );
  }


}