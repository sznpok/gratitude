import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/utils/size.dart';
import 'package:gratitude_app/utils/theme.dart';

import 'auth/ui/login_screen.dart';
import 'bloc/visibility_bloc/visibility_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => VisibilityBloc(),
      child: MaterialApp(
        title: 'Gratitude App',
        debugShowCheckedModeBanner: false,
        theme: theme(context),
        home: const LoginScreen(),
      ),
    );
  }
}
