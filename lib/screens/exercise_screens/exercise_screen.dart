import 'package:flutter/material.dart';
import 'package:train_app/models/exercise.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/screens/screens.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late Color color = Colors.white;
  late Color iconColor = Colors.black;

  @override
  void initState() {
    if (Preferences.isDarkMode) {
      color = Colors.grey[800]!;
      iconColor = Colors.white;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final exercise = ModalRoute.of(context)!.settings.arguments as Exercise;

    double width = MediaQuery.of(context).size.width * 0.35;
    double height = MediaQuery.of(context).size.height * 0.25;

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
        elevation: 1,
        iconTheme: IconThemeData(
          color: iconColor, //change your color here
        ),
      ),
      backgroundColor: color,
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: FadeInImage(
                placeholder: const AssetImage('images/jar-loading.gif'),
                image: AssetImage(exercise.getInfoimg!),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.width * 0.04
            ),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              exercise.getName!,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.1,
                fontWeight: FontWeight.w600
              ),
            )
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.bottomStart,
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.width * 0.04
                    ),
                    child: Text('Grupo muscular: ${exercise.getGroup}     ',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w500
                      )
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.01),
                    child: Text('Dificultad: ${exercise.getDifficulty}',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.w500
                      )
                    )
                  ),
                ]
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.height * 0.04
            ),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Músculos implicados: ',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w600
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.width * 0.04
            ),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '${exercise.getMuscles?[0]}',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.width * 0.01
            ),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '${exercise.getMuscles?[1]}',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              top: MediaQuery.of(context).size.height * 0.04
            ),
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Explicación: ',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w600
              ),
            )
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04,
                top: MediaQuery.of(context).size.width * 0.02),
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  '${exercise.getExplication?[0]}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Text(
                  '${exercise.getExplication?[1]}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: width,
                  height: height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      color: Colors.white,
                      child: FadeInImage(
                        placeholder: const AssetImage('images/jar-loading.gif'),
                        image: AssetImage('${exercise.getImages?[0]}'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  '${exercise.getExplication?[2]}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  width: width,
                  height: height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      color: Colors.white,
                      child: FadeInImage(
                        placeholder: const AssetImage('images/jar-loading.gif'),
                        image: AssetImage('${exercise.getImages?[1]}'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  '${exercise.getExplication?[3]}',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
              ],
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.25,
              right: MediaQuery.of(context).size.width * 0.25
            ),
            child: ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Center(
                  child: Text('Comenzar ejercicio',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04
                    )
                  )
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParameterExerciseScreen(),
                    settings: RouteSettings(
                      arguments: [exercise.getName!, exercise.getParameters!],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        ],
      ),
    );
  }
}
