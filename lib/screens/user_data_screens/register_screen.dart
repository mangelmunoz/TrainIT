
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:train_app/models/user.dart';
import 'package:train_app/screens/screens.dart';

import 'package:train_app/widgets/custom_input_field.dart';
import 'package:train_app/widgets/custom_input_field_altura.dart';
import 'package:train_app/widgets/custom_input_field_peso.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();

    User userData = User();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro de usuario', 
          style: TextStyle(
            fontSize: 25, 
            fontWeight: FontWeight.w500
          ),
        ),
        elevation: 10,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
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
                  hintText: '', 
                  modelProperty: 'name', 
                  userdata: userData
                ),
                const SizedBox(height: 25),
                CustomInputField(
                  labelText: 'Fecha de nacimiento (dd/mm/yyyy)', 
                  hintText: '', 
                  modelProperty: 'birthday', 
                  userdata: userData
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
                    size: 30
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
                  items: const [
                    DropdownMenuItem( value: '1', child: Text('Principiante')),
                    DropdownMenuItem( value: '2', child: Text('Intermedio')),
                    DropdownMenuItem( value: '3', child: Text('Avanzado')),
                  ],
                  onChanged: (value){
                   userData.setLevel = value ?? '1';
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
                        hintText: '', 
                        modelProperty: 'height', 
                        userdata: userData, 
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
                        hintText: '', 
                        modelProperty: 'weight', 
                        userdata: userData, 
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

                    if( !myFormKey.currentState!.validate() ) return;
 
                    SharedPreferences localStorage = await SharedPreferences.getInstance();
                    localStorage.setString('user', userData.getName!);
                    localStorage.setString('birthday', userData.getBirthday!);
                    localStorage.setString('level', userData.getLevel!);
                    localStorage.setString('weight', userData.getWeight!);
                    localStorage.setString('height', userData.getHeight!);

                    localStorage.setString('Register', '1');

                    Navigator.pushReplacement(
                      context, 
                      PageRouteBuilder(
                        pageBuilder: (
                          context, 
                          animation, 
                          secondaryAnimation
                        ) => HomeScreen(cameras),
                        transitionsBuilder: (
                        BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation,
                        Widget child
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
      ),
    );
  }
}