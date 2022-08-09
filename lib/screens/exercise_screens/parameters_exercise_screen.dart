
import 'package:flutter/material.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/screens/exercise_screens/curl_biceps_screen.dart';
import 'package:train_app/screens/screens.dart';

class ParameterExerciseScreen extends StatefulWidget {

  const ParameterExerciseScreen({Key? key,}) : super(key: key);

  @override
  State<ParameterExerciseScreen> createState() => _ParameterExerciseScreenState();
}

class _ParameterExerciseScreenState extends State<ParameterExerciseScreen> {
  
  late Color color = Colors.white;
  late Color iconColor = Colors.black;

  late int repetitions;
  late int series;
  late int restTime;

  @override
  void initState() {

    if(Preferences.isDarkMode){
      color = Colors.grey[800]!;
      iconColor = Colors.white;
    }
    
    repetitions = 0;
    series = 0;
    restTime = 0;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    final List<dynamic> exerciseArguments = ModalRoute.of(context)!.settings.arguments as List;
    final String exerciseName = exerciseArguments[0];
    final String parameters = exerciseArguments[1];

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
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.045, top: MediaQuery.of(context).size.height * 0.035),
            alignment: AlignmentDirectional.bottomCenter, 
            child: Text(
              exerciseName, 
              textAlign: TextAlign.start, 
              style: TextStyle(
                fontSize:  MediaQuery.of(context).size.height * 0.03
              )
            )
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.195),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  alignment: AlignmentDirectional.bottomStart, 
                  child: Text(
                    'Número de repeticiones', 
                    textAlign: TextAlign.start,  
                    style: TextStyle(
                      fontSize:  MediaQuery.of(context).size.width * 0.038
                    )
                  )
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.15,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                    // fillColor: const Color.fromARGB(255, 232, 232, 232),
                  ),
                  value: '-',
                  items: const [
                    DropdownMenuItem( value: '-', child: Text('-')),
                    DropdownMenuItem( value: '1', child: Text('1')),
                    DropdownMenuItem( value: '2', child: Text('2')),
                    DropdownMenuItem( value: '3', child: Text('3')),
                    DropdownMenuItem( value: '4', child: Text('4')),
                    DropdownMenuItem( value: '5', child: Text('5')),
                    DropdownMenuItem( value: '6', child: Text('6')),
                    DropdownMenuItem( value: '7', child: Text('7')),
                    DropdownMenuItem( value: '8', child: Text('8')),
                    DropdownMenuItem( value: '9', child: Text('9')),
                    DropdownMenuItem( value: '10', child: Text('10')),
                    DropdownMenuItem( value: '11', child: Text('11')),
                    DropdownMenuItem( value: '12', child: Text('12')),
                    DropdownMenuItem( value: '13', child: Text('13')),
                    DropdownMenuItem( value: '14', child: Text('14')),
                    DropdownMenuItem( value: '15', child: Text('15')),
                    DropdownMenuItem( value: '16', child: Text('16')),
                    DropdownMenuItem( value: '17', child: Text('17')),
                    DropdownMenuItem( value: '18', child: Text('18')),
                    DropdownMenuItem( value: '19', child: Text('19')),
                    DropdownMenuItem( value: '20', child: Text('20')),
                    DropdownMenuItem( value: '21', child: Text('21')),
                    DropdownMenuItem( value: '22', child: Text('22')),
                    DropdownMenuItem( value: '23', child: Text('23')),
                    DropdownMenuItem( value: '24', child: Text('24')),
                    DropdownMenuItem( value: '25', child: Text('25')),
                  ],    
                  menuMaxHeight: 200, 
                  onChanged: (value){
                    setState(() {
                      if(value != '-'){
                        repetitions = int.parse(value!);
                      }
                    });                    
                  }, 
                ),
              ),
            ]
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.195),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  alignment: AlignmentDirectional.bottomStart, 
                  child: Text(
                    'Número de series', 
                    textAlign: TextAlign.start,  
                    style: TextStyle(
                      fontSize:  MediaQuery.of(context).size.width * 0.038
                    )
                  )
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.15,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                  ),
                  value: '-',
                  items: const [
                    DropdownMenuItem( value: '-', child: Text('-')),
                    DropdownMenuItem( value: '1', child: Text('1')),
                    DropdownMenuItem( value: '2', child: Text('2')),
                    DropdownMenuItem( value: '3', child: Text('3')),
                    DropdownMenuItem( value: '4', child: Text('4')),
                    DropdownMenuItem( value: '5', child: Text('5')),
                    DropdownMenuItem( value: '6', child: Text('6')),
                    DropdownMenuItem( value: '7', child: Text('7')),
                    DropdownMenuItem( value: '8', child: Text('8')),
                    DropdownMenuItem( value: '9', child: Text('9')),
                    DropdownMenuItem( value: '10', child: Text('10')),
                  ],
                  menuMaxHeight: 200, 
                  onChanged: (value){
                    setState(() {
                      if(value != '-'){
                        series = int.parse(value!);
                      }
                    });
                  }, 
                ),
              ),  
            ]
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.195),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.height * 0.2,
                child: Container(
                  alignment: AlignmentDirectional.bottomStart, 
                  child: Text(
                    'Tiempo de descanso', 
                    textAlign: TextAlign.start,  
                    style: TextStyle(
                      fontSize:  MediaQuery.of(context).size.width * 0.038
                    )
                  )
                ),
              ),
              SizedBox(

                width: MediaQuery.of(context).size.height * 0.15,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    filled: true,
                  ),
                  value: '-',
                  items: const [
                    DropdownMenuItem( value: '-', child: Text('-')),
                    DropdownMenuItem( value: '5', child: Text('5 seg')),
                    DropdownMenuItem( value: '10', child: Text('10 seg')),
                    DropdownMenuItem( value: '15', child: Text('15 seg')),
                    DropdownMenuItem( value: '20', child: Text('20 seg')),
                    DropdownMenuItem( value: '25', child: Text('25 seg')),
                    DropdownMenuItem( value: '30', child: Text('30 seg')),
                    DropdownMenuItem( value: '35', child: Text('35 seg')),
                    DropdownMenuItem( value: '40', child: Text('40 seg')),
                    DropdownMenuItem( value: '45', child: Text('45 seg')),
                    DropdownMenuItem( value: '50', child: Text('50 seg')),
                    DropdownMenuItem( value: '55', child: Text('55 seg')),
                    DropdownMenuItem( value: '60', child: Text('60 seg')),
                  ],
                  menuMaxHeight: 200, 
                  onChanged: (value){
                    setState(() {
                      if(value != '-'){
                        restTime = int.parse(value!);
                      }
                    });
                  }, 
                ),
              ),  
            ]
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.195),
          Container(
            alignment: AlignmentDirectional.center,
            child: ElevatedButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: SizedBox(
                width:  MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Center(
                  child: Text(
                    'Comenzar actividad', 
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.04, 
                      fontWeight: FontWeight.w500,
                    ),
                  )
                )
              ),
              onPressed: () {

                if(repetitions == 0 || series == 0 || restTime == 0){
                  return;
                }
                else{

                  if(exerciseName == 'Press de hombros'){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ArmPressScreen(
                          cameras: cameras,
                          repetitions: repetitions,
                          series: series,
                          restTime: restTime,
                          parameters: parameters,
                        ),
                      ),
                    );
                  }
                   else if(exerciseName == 'Sentadillas'){
                     Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SquatsScreen(
                          cameras: cameras,
                          repetitions: repetitions,
                          series: series,
                          restTime: restTime,
                          parameters: parameters,
                        ),
                      ),
                    );
                   }
                   else if(exerciseName == 'Curl de bíceps'){
                     Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CurlBicepsScreen(
                          cameras: cameras,
                          repetitions: repetitions,
                          series: series,
                          restTime: restTime,
                          parameters: parameters,
                        ),
                      ),
                    );
                   }
                }
              }, 
            ),
          ),
        ],
      ),
    );
  }
}