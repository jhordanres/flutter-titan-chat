
import 'package:flutter/material.dart';

import 'package:titan_chat/pages/chat_page.dart';
import 'package:titan_chat/pages/loading_page.dart';
import 'package:titan_chat/pages/login_page.dart';
import 'package:titan_chat/pages/register_page.dart';
import 'package:titan_chat/pages/users_page.dart';

final Map<String, WidgetBuilder> appRoutes = {

  'usuarios' : ( _ ) => UsersPage(),
  'chat'     : ( _ ) => ChatPage(),
  'login'    : ( _ ) => LoginPage(),
  'register' : ( _ ) => RegisterPage(),
  'loading'  : ( _ ) => LoadingPage(),
};
