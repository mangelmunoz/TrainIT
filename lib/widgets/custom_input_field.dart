import 'package:flutter/material.dart';
import 'package:train_app/models/models.dart';

class CustomInputField extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;

  final String modelProperty;
  final User userdata; 

  const CustomInputField({
    Key? key, 
    this.hintText, 
    this.labelText, 
    this.helperText, 
    this.icon, 
    this.suffixIcon, 
    this.keyboardType, 
    this.obscureText, 
    required this.modelProperty, 
    required this.userdata,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      initialValue: hintText,
      textCapitalization: TextCapitalization.words,
      keyboardType: keyboardType ?? TextInputType.name,
      obscureText: obscureText == null ? false : true,
      onChanged: (value) {
        if(modelProperty == 'name'){
          userdata.setName = value;
        }
        if(modelProperty == 'birthday'){
          userdata.setBirthday =  value;
        }
      },
      validator: (value) {
        if(value == null) return 'Este campo es requerido';
        if(modelProperty == 'birthday'){
          final birthday = RegExp(r"^([0-2][0-9]|3[0-1])(\/|-)(0[1-9]|1[0-2])\2(\d{4})$");
          return  birthday.allMatches(value).isEmpty ? 'Formato incorrecto' : null ;
        }
        return value.length < 3 ? 'Mínimo debe tener 3 caracteres' : null ;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
      )
    );
  }
}

