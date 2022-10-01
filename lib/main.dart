import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:titan_chat/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Titan Chat',
      initialRoute: 'chat',
      routes: appRoutes,
    );
  }
}
