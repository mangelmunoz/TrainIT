
import 'package:flutter/material.dart';
import 'package:train_app/preferences/preferences.dart';

class GeneralHelpScreen extends StatefulWidget {
  const GeneralHelpScreen({Key? key}) : super(key: key);

  @override
  State<GeneralHelpScreen> createState() => _GeneralHelpScreenState();
}

class _GeneralHelpScreenState extends State<GeneralHelpScreen> {

  bool exercise = false;
  bool stadistics = false;
  IconData exerciseIcon = Icons.keyboard_arrow_right;
  IconData stadisticsIcon = Icons.keyboard_arrow_right;

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Ayuda general', 
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.1, 
                  fontWeight: FontWeight.bold
                ),
              )
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
                      width:  MediaQuery.of(context).size.width * 0.6,
                      child: Text(
                        'Crear sesi??n de entrenamiento', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042, 
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.2),
                    Icon(exerciseIcon)
                  ],
                )
              ),                        
              onTap: () {                          
                setState(() {
                  exercise = !exercise;
                  if(exercise){
                    exerciseIcon = Icons.keyboard_arrow_down;
                  }
                  else{
                    exerciseIcon = Icons.keyboard_arrow_right;
                  }
                });
              },                      
            ),
            Visibility(
              visible : exercise,
              child: Container(
                width:  MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05, 
                  top: MediaQuery.of(context).size.height * 0.025, 
                  bottom: MediaQuery.of(context).size.height * 0.025
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '1. Ve a la ventana principal, y selecciona el ejercicio que deseas realizar.', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        )
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.width * 0.05),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '2. Pulsa el bot??n "Comenzar ejercicio" de la ventana de ejercicio.', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        )
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.width * 0.05),                                
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '3. Introduce los par??metros de la sesi??n de entrenamiento. Estos par??metros ser??n:', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        )
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.width * 0.05),
                    Text(
                      '- N??mero de repeticiones por serie.                    ', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.width * 0.03),
                    Text(
                      '- N??mero de series por sesi??n.                            ', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.width * 0.03),
                    Text(
                      '- Tiempo de descanso entre series.                    ', 
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.04
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.width * 0.05),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '4. Una vez introducidos los par??metros, pulsa el bot??n "Comenzar actividad".',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        )
                      )
                    ),
                    
                  ],    
                ),
              )
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
                    SizedBox(width: MediaQuery.of(context).size.width * 0.75,
                      child: Text(
                        'Visualizar estad??sticas de un ejercicio determinado', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.042, 
                          fontWeight: FontWeight.w500
                        ), 
                        maxLines: 2
                      ),
                    ),
                    SizedBox(width:MediaQuery.of(context).size.width * 0.035),
                    Icon(stadisticsIcon)
                  ],
                )
              ),                        
              onTap: () {                          
              setState(() {
                  stadistics = !stadistics;
                  if(stadistics){
                    stadisticsIcon = Icons.keyboard_arrow_down;
                  }
                  else{
                    stadisticsIcon = Icons.keyboard_arrow_right;
                  }
                });
              },                      
            ),
            Visibility(
              visible : stadistics,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05, 
                  top: MediaQuery.of(context).size.height * 0.025,
                  bottom: MediaQuery.of(context).size.height * 0.025
                ), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '1. Ve a la ventana de perfil, y selecciona el bot??n "Ver estad??sticas".', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        )
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height * 0.05),
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '2. Pulsa el bot??n "Ver estad??sticas por ejercicio" de la ventana de estad??sticas.', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        )
                      )
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height * 0.05),                                
                    SizedBox(
                      width:  MediaQuery.of(context).size.width * 0.9,
                      child: Text(
                        '3. Selecciona en el elemento desplegable el ejercicio del cual deseas ver sus estad??sticas.', 
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04
                        )
                      )
                    ),
                  ],
                ),
              )
            ), 
            const Divider()
          ],
        ),
      )
    );
  }
}