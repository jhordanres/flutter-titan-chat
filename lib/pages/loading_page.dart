
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:titan_chat/pages/login_page.dart';
import 'package:titan_chat/pages/users_page.dart';

import 'package:titan_chat/services/auth_service.dart';

class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Autenticando...'),
          );
        },
      )
    );
  }

  Future checkLoginState( BuildContext context ) async {

    final authService = Provider.of<AuthService>(context, listen: false);

    final authenticated = await authService.isLoggeIn();

    if( authenticated == true ) {
      //TODO: Conectar al socket server
      //Navigator.pushReplacementNamed(context, 'users');
      //Si quiero un cambio de pantalla con amimación simplemente coloco una ruta así
      Navigator.pushReplacement(context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsersPage(),
          transitionDuration: Duration(milliseconds: 0),
        )
      );
    } else {
      //Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(context, 
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0),
        )
      );
    }
    
  }
}
