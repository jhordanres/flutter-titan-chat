import 'dart:io';

class Enviroment {
  //Creo estas variables de entorno para la comunicación de socket
  // y comunicación de servicio res (url) de la api para cada una de las plataformas
  //Esto porque android no tranajo con localhost sino con 10.0.2.2
  static String apiUrl = Platform.isAndroid
      ? 'http://192.168.10.15:3000/api'
      : 'http://localhost:3000/api';
  static String socketUrl = Platform.isAndroid 
      ? 'http://10.0.2.2:3000'
      : 'http://localhost:3000';
}
