import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/auth/bloc/login_blo/login_bloc.dart';
import 'package:gratitude_app/auth/bloc/register_bloc/register_bloc.dart';
import 'package:gratitude_app/detail_gratitude/bloc/gratitude_delete_bloc/gratitude_delete_bloc.dart';
import 'package:gratitude_app/detail_gratitude/bloc/update_gratitude_bloc/update_gratitude_bloc.dart';
import 'package:gratitude_app/list_gratitude/list_gratitude_bloc/list_gratitude_bloc.dart';
import 'package:gratitude_app/post_gratitude/bloc/post_gratitude_bloc/post_gratitude_bloc.dart';
import 'package:gratitude_app/splash_screen.dart';
import 'package:gratitude_app/utils/size.dart';
import 'package:gratitude_app/utils/theme.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => VisibilityBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => PostGratitudeBloc(),
        ),
        BlocProvider(
          create: (context) => ListGratitudeBloc(),
        ),
        BlocProvider(
          create: (context) => GratitudeDeleteBloc(),
        ),
        BlocProvider(
          create: (context) => UpdateGratitudeBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Gratitude App',
        debugShowCheckedModeBanner: false,
        theme: theme(context),
        home: const SplashScreen(),
      ),
    );
  }
}
