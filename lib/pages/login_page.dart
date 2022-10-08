import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:titan_chat/helpers/show_alert.dart';

import 'package:titan_chat/widgets/custom_labels.dart';
import 'package:titan_chat/widgets/custom_logo.dart';
import 'package:titan_chat/widgets/custom_input.dart';
import 'package:titan_chat/widgets/custom_btn_azul.dart';

import 'package:titan_chat/services/auth_service.dart';

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

    final authService = Provider.of<AuthService>(context);

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
            //Colocamos la condicional para decirle que si se esta loguenando me desactive el boton
            onPressed: authService.authenticating ? null :() async {
              
              //Aquí quito el teclado despues de presionar logueo
              FocusScope.of(context).unfocus();
              
              final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());

              if ( loginOk ) {
                //TODO: Conectar a nuestro Socket Server

                //Despues de que todo sale bien en el login navego a otra pantalla
                //con el replacenamed porque no quiero que regresen a la pantalla login
                Navigator.pushReplacementNamed(context, 'users');
              } else {
                // Mostrar alerta
                showAlert(context, 'Login incorrecto', 'Revisa tus credenciales');
              }
            }
          )  
        ],
      ),
    );
  }
}

