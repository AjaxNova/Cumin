import 'package:cumin_task/db/functions/db_functions.dart';
import 'package:cumin_task/pages/sign_up_screen.dart';
import 'package:cumin_task/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UserDataProvider>(
      builder: (context, value, child) {
        return Column(
          children: [
            const ListTile(
              title: Text(
                "User Datails",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                Icons.arrow_right,
                size: 31,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQA1jpTVrugJwXmZc6WPdw6VPSZ2Tm5mIq7A&s")),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomDisplayTextField(
                  val: value.currentuser!.name,
                ),
                CustomDisplayTextField(
                  val: value.currentuser!.email,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await clearAllSharedPreferences();

                      value.logOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()),
                          (Route<dynamic> route) => false);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          "Log Out",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ));
  }
}

class CustomDisplayTextField extends StatelessWidget {
  const CustomDisplayTextField({
    super.key,
    required this.val,
  });
  final String val;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: val,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
