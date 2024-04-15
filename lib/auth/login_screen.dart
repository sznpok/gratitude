import 'package:flutter/material.dart';
import 'package:gratitude_app/auth/register_screen.dart';

import '../../../utils/size.dart';
import '../list_gratitude/list_gratitude_screen.dart';
import '../utils/theme.dart';

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
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              const Text('Password'),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: "password",
                  border: OutlineInputBorder(),
                ),
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
                    SizeConfig.screenHeight! * 0.08,
                  ),
                ),
                child: Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: primaryColor),
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
