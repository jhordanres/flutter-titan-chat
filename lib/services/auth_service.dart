import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:titan_chat/global/enviroment.dart';

import 'package:titan_chat/models/login_response.dart';
import 'package:titan_chat/models/user.dart';

class AuthService with ChangeNotifier {
  //Me creo una instancia de la clase modelo User
  User? user;

  //Me creo unos metodos getters y setters para notificarle a
  //todos los utuarios si el user se esta autenticando o no
  bool _authenticating = false;

  //Me creo la instancia del storage para almagenar el JWT
  final _storage = new FlutterSecureStorage();

  bool get authenticating => this._authenticating;

  set authenticating(bool value) {
    this._authenticating = value;

    //Aqui llamo al notifiy porque va a cambiar el valor de la
    //propiedad entonces les tengo que notificar eso a los demas
    notifyListeners();
  }

  //Me creo getters y setters para acceder al token desde cualqueier pantalla
  // Ya sea para leerlo, eliminarlo ...
  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.delete(key: 'token');
  }

  //Creo metodo que me retorna un Future para el login
  Future<bool> login(String email, String password) async {
    //Cuando empiezo el login llamo el set de authenticating y lo coloco
    //en true para que sepan que me estoy loguenando
    this.authenticating = true;

    //Trabajo el payload que voy a mandar al backend
    final data = {'email': email, 'password': password};

    //Construyo el Url para el login
    final uri = Uri.parse(
      '${Enviroment.apiUrl}/login',
    );
    final resp = await http.post(uri,
        body: jsonEncode(data), headers: {'content-Type': 'application/json'});

    this.authenticating = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      // TODO: Guardar token en lugar seguro
      await this._saveToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {

    //Cuando empiezo el login llamo el set de authenticating y lo coloco
    //en true para que sepan que me estoy loguenando
    authenticating = true;

    //Trabajo el payload que voy a mandar al backend
    final data = {'name': name,'email': email, 'password': password};

    //Construyo el Url para el register
    final uri = Uri.parse(
      '${Enviroment.apiUrl}/login/new',
    );
    final resp = await http.post(uri,
      body: jsonEncode(data), headers: {'content-Type':'application/json'}
    );
    print(resp.body);
    authenticating = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      // TODO: Guardar token en lugar seguro
      await _saveToken(loginResponse.token);

      return true;
    } else {
      //Mapeo la respuesta para poderla mostar
      final respBody = jsonDecode(resp.body);
      List<String> erroresMsg=[];
        for (var item in (respBody['errores']).values) {
        erroresMsg.add(item['msg']);
 
        }    
        return erroresMsg.join("\n");
    }
    
  }
  //Metodo para preguntar si aun sigue un token activo, esto con el fin de que
  //cuando el usuario se salga de la app no lo mande de nuevo a la pantalla de login
  Future<bool> isLoggeIn() async {

    //Primero voy a leer el token 
    final token = await _storage.read(key: 'token');

    final uri = Uri.parse(
      '${Enviroment.apiUrl}/login/renew',
    );
    final resp = await http.get(uri,
      headers: {
        'content-Type':'application/json',
        'x-token':token!
      }
    );

    if( resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;
      await _saveToken(loginResponse.token);
      return true;
    } else {
      logout();
      return false;
    }

  }

  //Me creo el metodo que me permitira guardar el Token
  Future _saveToken(String token) async {
    // Write value
    return await _storage.write(key: 'token', value: token);
  }

  //Elimino el token cuando me desloguee de la app
  Future logout() async {
    // Delete value
    await _storage.delete(key: 'token');
  }
}
