import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_app/models/models.dart';
import 'package:train_app/preferences/preferences.dart';
import 'package:train_app/screens/screens.dart';
import 'package:train_app/widgets/widgets.dart';
class EditUserDataScreen extends StatefulWidget {
   
  const EditUserDataScreen({Key? key}) : super(key: key);

  @override
  State<EditUserDataScreen> createState() => _EditUserDataScreenState();
}

class _EditUserDataScreenState extends State<EditUserDataScreen> {
  late Color color = Color.fromARGB(255, 207, 51, 51);
  late Color iconColor =  Colors.black;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(Preferences.isDarkMode){
      color = Colors.grey[800]!;
      iconColor = Colors.white;
    }
   
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
        elevation: 10,
        iconTheme: IconThemeData(
          color: iconColor, 
        ),
      ),
      body: _showUserData()
    );
  }

  Future<User> _getUserData() async {
    
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    late User userData = User();

    userData.setName = localStorage.getString('user');
    userData.setBirthday = localStorage.getString('birthday');
    userData.setLevel = localStorage.getString('level');
    userData.setHeight = localStorage.getString('height');
    userData.setWeight = localStorage.getString('weight');
    
    return userData;
  }

  FutureBuilder<dynamic> _showUserData() {

    return FutureBuilder(
      future: _getUserData(),
      builder: (BuildContext context, snapshot) {

        if (snapshot.data != null) {

          final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal:35, 
                vertical:35
              ),
              child: Form(
                key: myFormKey,
                child: Column(
                  children: [
                    CustomInputField(
                      labelText: 'Nombre del usuario', 
                      hintText: snapshot.data.getName, 
                      modelProperty: 'name', 
                      userdata: snapshot.data
                    ),
                    const SizedBox(height: 25),
                    CustomInputField(
                      labelText: 'Fecha de nacimiento (dd/mm/yyyy)', 
                      hintText: snapshot.data.getBirthday, 
                      modelProperty: 'birthday', 
                      userdata: snapshot.data
                    ),
                    const SizedBox(height: 50),
                    Container(
                      alignment: AlignmentDirectional.bottomStart, 
                      child: const Text(
                        'Nivel de entrenamiento',
                        textAlign: TextAlign.start
                      )
                    ),
                    const SizedBox(height:  25),
                    DropdownButtonFormField<String>(
                      iconSize: 80,
                      icon: const Icon(
                        Icons.arrow_drop_down_sharp, 
                        size: 30,
                      ),
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
                      value: snapshot.data.getLevel,
                      items: const [
                        DropdownMenuItem( value: '1', child: Text('Principiante')),
                        DropdownMenuItem( value: '2', child: Text('Intermedio')),
                        DropdownMenuItem( value: '3', child: Text('Avanzado')),
                      ],
                      onChanged: (value){
                        snapshot.data.getLevel = value ?? '1';
                      }, 
                    ),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.bottomStart, 
                          child: const Text(
                            'Altura del usuario (cms)', 
                            textAlign: TextAlign.start
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 60
                          ),
                          alignment: AlignmentDirectional.bottomStart,
                          width: 110,
                          child: CustomInputFieldAltura(
                            labelText: 'cm', 
                            hintText: snapshot.data.getHeight, 
                            modelProperty: 'height', 
                            userdata: snapshot.data
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(height:15),
                    Row(
                      children: [
                        Container(
                          alignment: AlignmentDirectional.bottomStart, 
                          child: const Text(
                            'Peso del usuario (kg)', 
                            textAlign: TextAlign.start
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 78
                          ),
                          alignment: AlignmentDirectional.bottomStart,
                          width: 110,
                          child: CustomInputFieldPeso(
                            labelText: 'kg', 
                            hintText: snapshot.data.getWeight, 
                            modelProperty: 'weight', 
                            userdata: snapshot.data
                            ),
                        ),
                      ]
                    ),
                    const SizedBox(height: 45),
                    ElevatedButton(
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text('Guardar')
                        )
                      ),
                      onPressed: () async {

                        if(!myFormKey.currentState!.validate()) return;
                        
                        SharedPreferences localStorage = await SharedPreferences.getInstance();
                        localStorage.setString('user', snapshot.data.getName!);
                        localStorage.setString('birthday', snapshot.data.getBirthday!);
                        localStorage.setString('level', snapshot.data.getLevel!);
                        localStorage.setString('weight', snapshot.data.getWeight!);
                        localStorage.setString('height', snapshot.data.getHeight!);

                        Navigator.pushReplacement(
                          context, 
                          PageRouteBuilder(
                            pageBuilder: (
                              context, 
                              animation, 
                              secondaryAnimatio
                            ) => const PreferencesScreen(),
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
                      }, 
                    )
                  ],
                ),
              )
            )
          );
        } 
        else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
