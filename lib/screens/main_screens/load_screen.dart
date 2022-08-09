
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/screens/screens.dart';

class LoadScreen extends StatefulWidget {
  const LoadScreen({Key? key}) : super(key: key);

  @override
  State<LoadScreen> createState() => _LoadScreenState();
}

class _LoadScreenState extends State<LoadScreen> {

  late Color color;
  
  @override
  void initState() {

     if(Preferences.isDarkMode){
      color = Colors.white;
    }
    else{
      color =  const Color.fromARGB(255, 206, 1, 1);
    }
    
    waitFunction().then((val) {
      isFirstTime();
    });
    
    super.initState();
  }
  
  Future<void> isFirstTime() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if(localStorage.getString('Register') == null){
     Navigator.pushReplacement(context,
        MaterialPageRoute(
          builder: (context) => const RegisterScreen()
        ),
      );
    }
    else{
      Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomeScreen(cameras),
          transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) => FadeTransition(
                opacity: animation,
                child: child,
              ),
        )
      );
    }
  }


  Future<String> waitFunction() async {
    await Future.delayed(const Duration(seconds: 2));
    return "123";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          width: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          child: Text(
            'TrainIT',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize:  MediaQuery.of(context).size.height * 0.06,
              fontFamily: 'Title font'  
            ),
          ),
        )
      ) 
    );
  }
}