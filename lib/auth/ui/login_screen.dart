import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/auth/bloc/login_blo/login_bloc.dart';
import 'package:gratitude_app/auth/ui/register_screen.dart';
import 'package:gratitude_app/bloc/visibility_bloc/visibility_bloc.dart';
import 'package:gratitude_app/bloc/visibility_bloc/visibility_state.dart';
import 'package:gratitude_app/utils/constant.dart';
import 'package:gratitude_app/utils/secure_storage.dart';
import 'package:gratitude_app/utils/validation.dart';

import '../../../../utils/size.dart';

import '../../bloc/visibility_bloc/visibility_event.dart';
import '../../list_gratitude/ui/list_gratitude_screen.dart';
import '../../utils/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  void submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    await writeUserEmail(_emailController.text);
    BlocProvider.of<LoginBloc>(context).add(
      OnLoginEvent(
        _emailController.text,
        _passwordController.text.trim(),
      ),
    );
  }

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
          child: Form(
            key: _formKey,
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
                  validator: (value) => ValidationMixin().validateEmail(value!),
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
                          icon: Icon(visible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      validator: (value) =>
                          ValidationMixin().validatePassword(value!),
                    );
                  },
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.02,
                ),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Invalid Credential"),
                        backgroundColor: Colors.red,
                      ));
                    } else if (state is LoginSuccessState) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ListGratitudeScreen()),
                          (route) => false);
                      ;
                    }
                  },
                  builder: (context, state) {
                    return state is LoginLoadingState
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : TextButton(
                            onPressed: () {
                              submit();
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          );
                  },
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
      ),
    );
  }
}
