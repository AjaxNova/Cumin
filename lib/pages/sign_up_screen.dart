import 'dart:developer';

import 'package:cumin_task/pages/log_in_screen.dart';
import 'package:cumin_task/provider/user_data_provider.dart';
import 'package:cumin_task/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//used stateful widget just to use the dispose method to effectively dispose the texteditingcontrollers//
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  _onSubmit() async {
    log("submit button clicked");
    final val = Provider.of<UserDataProvider>(context, listen: false);
    val.turnSignUpLoadinOn();

    final data = await val.signUpUserToDb(
        username: _nameController.text,
        password: _passwordController.text,
        email: _emailController.text);
    if (data == "error") {
      val.setEmailErrortext();
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      val.turnSignUpLoadinOff();
      const snackBar = SnackBar(
        content: Text('Email Is Already In Use'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
      val.clearEmailError();
      val.turnSignUpLoadinOff();
      const snackBar = SnackBar(
        content: Text('User registered Sucessfully'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 3,
            shadowColor: Colors.white,
            backgroundColor: Colors.black,
            title: const Text(
              "PIXELS",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                value.isSignUpLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.orange,
                        ),
                      )
                    : Form(
                        key: _formKey,
                        child: Card(
                          elevation: 3,
                          color: Colors.white10.withRed(1),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "SignUp",
                                  style: TextStyle(fontSize: 27),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomTextfield(
                                  controller: _nameController,
                                  hinttext: "Name"),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfield(
                                  errorText: value.emailError,
                                  controller: _emailController,
                                  hinttext: "Email"),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfield(
                                controller: _passwordController,
                                hinttext: "Password",
                                isObscure: true,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (_formKey.currentState!.validate() ==
                                        true) {
                                      await _onSubmit();
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: const Center(
                                      child: Text(
                                        "Register",
                                        style: TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                value.isSignUpLoading
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LogInScreen(),
                              ));
                            },
                            child: const Text(
                              "Already registerd? Login",
                            )),
                      )
              ],
            ),
          ),
        );
      },
    );
  }
}
