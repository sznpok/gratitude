import 'package:flutter/material.dart';
import 'package:gratitude_app/utils/size.dart';
import 'package:gratitude_app/utils/theme.dart';

import 'auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      title: 'Gratitude App',
      debugShowCheckedModeBanner: false,
      theme: theme(context),
      home: const LoginScreen(),
    );
  }
}
