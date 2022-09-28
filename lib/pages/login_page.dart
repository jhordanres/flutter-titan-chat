import 'package:flutter/material.dart';
import 'package:titan_chat/widgets/custom_btn_azul.dart';

import 'package:titan_chat/widgets/custom_labels.dart';
import 'package:titan_chat/widgets/custom_logo.dart';
import 'package:titan_chat/widgets/custom_input.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                CustomLogo(
                  image: AssetImage('assets/tag-logo.png'), 
                  text: 'Titan Chat'
                ),
        
                _Form(),
        
                Labels(
                  title: 'No tienes cuenta?',
                  subTitle: 'Crea una ahora!',
                  route: 'register',
                ),
        
                Text('Terminos y condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      )
    );
  }
}



class _Form extends StatefulWidget {

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Email',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outlined,
            placeholder: 'Password',
            keyboardType: TextInputType.emailAddress,
            textController: passCtrl,
            isPassword: true,
          ),

          BlueButton(
            text: 'Login', 
            onPressed: (){
              print(emailCtrl.text);
              print(passCtrl.text);
            }
          )  
        ],
      ),
    );
  }
}

