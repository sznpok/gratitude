import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/auth/bloc/register_bloc/register_bloc.dart';
import 'package:gratitude_app/utils/validation.dart';

import '../../list_gratitude/ui/list_gratitude_screen.dart';
import '../../utils/constant.dart';
import '../../utils/secure_storage.dart';
import '../../utils/size.dart';
import '../../utils/theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _onSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    String? token = await readTokenAccess();
    AccessToken.tokenAccess = token.toString();
    BlocProvider.of<RegisterBloc>(context).add(OnClickRegisterEvent(
      password: _passwordController.text,
      email: _emailController.text,
      name: _nameController.text,
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(
          SizeConfig.padding! * 0.03,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                const Text('Full name'),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter your full name ",
                    prefixIcon: Icon(
                      Icons.person,
                      color: secondaryColor,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => ValidationMixin().validateName(
                    value!,
                    title: "name is required",
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                const Text('Email'),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your email address",
                    prefixIcon: Icon(
                      Icons.email,
                      color: secondaryColor,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => ValidationMixin().validateEmail(value!),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                const Text('Password'),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "Create a password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.lock,
                      color: secondaryColor,
                    ),
                  ),
                  validator: (value) =>
                      ValidationMixin().validatePassword(value!),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error to register'),
                        ),
                      );
                    } else if (state is RegisterSuccessState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListGratitudeScreen(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return state is RegisterLoadingState
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : TextButton(
                            onPressed: () {
                              _onSubmit();
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: secondaryColor,
                              fixedSize: Size(
                                SizeConfig.screenWidth!,
                                SizeConfig.screenHeight! * 0.07,
                              ),
                            ),
                            child: Text(
                              'Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                            ));
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
