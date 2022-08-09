import 'package:flutter/material.dart';
import 'package:train_app/models/models.dart';

class CustomInputFieldPeso extends StatelessWidget {

  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;

  final String modelProperty;
  final User userdata; 

  const CustomInputFieldPeso({
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
          userdata.setWeight = value;    
      },
      validator: (value) {
        if(value == null) return 'Este campo es requerido';
        return value.length < 2 ? 'Mínimo 2 caracteres' : null ;
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