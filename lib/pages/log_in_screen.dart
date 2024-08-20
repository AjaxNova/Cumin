import 'dart:developer';

import 'package:cumin_task/pages/home_page.dart';
import 'package:cumin_task/provider/user_data_provider.dart';
import 'package:cumin_task/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
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
    return Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            foregroundColor: Colors.white,
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
                value.isLoginLoading
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
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              CustomTextfield(
                                  errorText: value.emailError,
                                  controller: _emailController,
                                  hinttext: "Email"),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomTextfield(
                                errorText: value.logInPassWordError,
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
                                      await _onLogIn();
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
                                        "Log In",
                                        style: TextStyle(fontSize: 26),
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
              ],
            ),
          ),
        );
      },
    );
  }

  _onLogIn() async {
    log("login button pressed");

    final val = Provider.of<UserDataProvider>(context, listen: false);
    val.turnLogInLoadinOn();
    final data = await val.signInUserToDb(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);

    if (data == "password is incorrect") {
      val.setLogInPasswordError(data);
      val.setLogInPasswordError(data);
      final snackBar = SnackBar(
        content: Text(data),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (data == "user not found") {
      val.setLogInPasswordError(data);
      final snackBar = SnackBar(
        content: Text(data),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      _emailController.clear();
      _passwordController.clear();
      val.clearEmailError();
      val.clearLogInpassError();

      final snackBar = SnackBar(
        content: Text(data),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (Route<dynamic> route) => false);

      //sucess state;
    }
    val.turnLogInLoadinOff();
  }
}
