
import 'package:flutter/material.dart';

class ThemePresenter extends ChangeNotifier{

  ThemeData currentTheme;
  Color iconColor = Colors.white;


  ThemePresenter({
    required bool isDarkMode
  }): currentTheme = isDarkMode 
        ? ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white)
            )
          )

        : ThemeData.light().copyWith(
            primaryColor: Colors.white,
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              titleTextStyle: TextStyle(color: Color.fromARGB(255, 206, 1, 1))
            ),
            bottomAppBarColor: Colors.white
          );

  setLightMode(){
    currentTheme = ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 206, 1, 1)
        )
      ),
      bottomAppBarColor: Colors.white
    );
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(
          color: Colors.white
        )
      )
    );
    
    iconColor = Colors.white;
    notifyListeners();
  }
}