import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/auth/ui/register_screen.dart';
import 'package:gratitude_app/bloc/visibility_bloc/visibility_bloc.dart';
import 'package:gratitude_app/bloc/visibility_bloc/visibility_state.dart';

import '../../../../utils/size.dart';

import '../../bloc/visibility_bloc/visibility_event.dart';
import '../../list_gratitude/list_gratitude_screen.dart';
import '../../utils/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Back !!!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.padding! * 0.03,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              const Text('Email'),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "email",
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              const Text('Password'),
              BlocBuilder<VisibilityBloc, VisibilityState>(
                builder: (context, state) {
                  bool visible = (state as VisibilityToggled).visible;
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: !visible,
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "password",
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          BlocProvider.of<VisibilityBloc>(context)
                              .add(ToggleVisibilityEvent());
                        },
                        icon: Icon(
                            visible ? Icons.visibility : Icons.visibility_off),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListGratitudeScreen()));
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: secondaryColor,
                  fixedSize: Size(
                    SizeConfig.screenWidth!,
                    SizeConfig.screenHeight! * 0.06,
                  ),
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.05,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'If not registered, please registered here ',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge!,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.01,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()));
                  },
                  child: Text(
                    'Create account',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
