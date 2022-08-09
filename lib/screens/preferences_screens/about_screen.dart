import 'package:flutter/material.dart';
import 'package:train_app/preferences/preferences.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({ Key? key }) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

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
        iconTheme: IconThemeData(
          color: iconColor, 
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width * 0.05  ,top: MediaQuery.of(context).size.height * 0.045),
              child: Text(
                'Acerca de', 
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.1, 
                  fontWeight: FontWeight.bold
                ),
              )
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.06),
              alignment: AlignmentDirectional.centerStart,
              child: Text( 
                'Esta aplicación ha sido diseñada por Miguel Ángel Muñoz Martín, perteneciente al grado de Ingeniería Informatica de la Universidad de Córdoba, como Trabajo de Fin de Grado.', 
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045, 
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.justify
              )
            ),
            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.02),
              alignment: AlignmentDirectional.centerStart,
              child: Text( 
                'El proyecto ha sido dirigido por el Dr. Manuel Jesús Marín Jiménez, y codirigido por Dª Nuria Marín Jiménez.', 
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045, 
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.justify
              )
            ),

            Container(
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05, right: MediaQuery.of(context).size.width * 0.05, top: MediaQuery.of(context).size.height * 0.02),
              alignment: AlignmentDirectional.centerStart,
              child: Text( 
                'Agradecimientos a Rafael Aguilar, por su ayuda en el desarrollo de la aplicación.', 
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.045, 
                  fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.justify
              )
            ),
          ],
        ),
      )  
    );
  }
}