
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/providers/presenter.dart';
import 'package:train_app/screens/screens.dart';

class PreferencesScreen extends StatefulWidget {

  const PreferencesScreen({Key? key}) : super(key: key);

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {

  int _selectedIndex = 0;
  late Color color = const Color.fromARGB(255, 207, 51, 51);
  late Color iconColor =  Colors.black;
  

  @override
  void initState() {

    if(Preferences.isDarkMode){
      color = Colors.grey[800]!;
      iconColor = Colors.white;
    }
    super.initState();
   
  }
    
  void _changeView(int index) {

    setState(() {
      _selectedIndex = index;
    });

    if(_selectedIndex == 1){
      Navigator.push(context,  MaterialPageRoute(
      builder: (context) => const ProfileScreen()));
    }
    else{
      Navigator.push(context,  MaterialPageRoute(
      builder: (context) => HomeScreen(cameras)));
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const ProfileScreen()), 
              (Route<dynamic> route) => false
          );
          return Future.value(false);
      },
      child: Scaffold(
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
          iconTheme: IconThemeData(
            color: iconColor, //change your color here
          ),
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
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  left:  MediaQuery.of(context).size.width * 0.035  ,
                  top: MediaQuery.of(context).size.height * 0.025, 
                  bottom: MediaQuery.of(context).size.height * 0.015
                ),
                child: Text(
                  'Preferencias', 
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1, 
                    fontWeight: FontWeight.bold
                  ),
                )
              ),
              const Divider(),
              Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.005,
                  bottom: MediaQuery.of(context).size.height * 0.005
                ),
                child: SwitchListTile.adaptive(
                  value: Preferences.isDarkMode,
                  title: Container(
                    margin:EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.02
                    ), 
                    child: Text(
                      'Modo oscuro' , 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.045
                      )
                    )
                  ), 
                  onChanged: (value) {
                    Preferences.isDarkMode = value;
                    final themeProvider = Provider.of<ThemePresenter>(context, listen:false);
                    value 
                    ? themeProvider.setDarkMode() 
                    : themeProvider.setLightMode();
                    
                    setState(() {
                      if(Preferences.isDarkMode){
                        iconColor = Colors.white;
                      }
                      else{
                        iconColor = Colors.black;
                      }
                    });
                  }
                ),
              ),
              const Divider(),
              InkWell(                        
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025, 
                    bottom: MediaQuery.of(context).size.height * 0.025
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width:  MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          'Ayuda general', 
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.045
                          ),
                        ),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width * 0.2),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )
                ),                        
                onTap: () {                          
                Navigator.push(
                  context,  
                  MaterialPageRoute(
                    builder: (context) => const GeneralHelpScreen()
                  )
                );
                },                      
              ),
              const Divider(),
              InkWell(                        
                child: Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.025, 
                    bottom: MediaQuery.of(context).size.height * 0.025
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          'Datos del usuario', 
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.045
                          ),
                        ),
                      ),
                      SizedBox(width:MediaQuery.of(context).size.width * 0.2),
                      const Icon(Icons.keyboard_arrow_right)
                    ],
                  )
                ),                        
                onTap: () {                          
                  Navigator.push(
                    context,  
                    MaterialPageRoute(
                      builder: (context) => const EditUserDataScreen()
                    )
                  );
                },                      
              ),
              const Divider(),
              InkWell(                        
                child: 
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.025, 
                      bottom: MediaQuery.of(context).size.height * 0.025
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width:  MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            'Acerca de', 
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width * 0.045
                            ),
                          ),
                        ),
                        SizedBox(width:MediaQuery.of(context).size.width * 0.2),
                        const Icon(Icons.keyboard_arrow_right)
                      ],
                    )
                  ),                        
                onTap: () {                          
                  Navigator.push(
                    context,  
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen()
                    )
                  );
                },                      
              ),
              const Divider()
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.house),
              label: '',
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: iconColor,
          selectedItemColor: iconColor,
          iconSize: MediaQuery.of(context).size.height * 0.04,
          elevation: 25.0,
          onTap: _changeView,
        ),
      ),
    );
  }
}