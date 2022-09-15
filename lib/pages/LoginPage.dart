import 'dart:developer';

import 'package:easytax/helper/WaitingProcess.dart';
import 'package:easytax/pages/HomePage.dart';
import 'package:easytax/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final mainProvider = Provider.of<MainProvider>(context);

    return Scaffold(
        body: Form(
      key: formkey,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "welcome",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/taxlogo.png",
                  width: 200,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onSaved: (String? val) {
                    username = val;
                  },
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return "Enter your username";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    // focusColor: primary,
                    // fillColor: fillColor,
                    filled: true,
                    prefixIcon: Icon(Icons.account_circle),
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    // labelText: 'Username',
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (String? val) {
                    password = val;
                  },
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return "Enter your password";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    // focusColor: primary,
                    // fillColor: fillColor,
                    filled: true,
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                      Waiting.show(context);
                      mainProvider.login(username, password).whenComplete(() {
                        Waiting.hide(context);
                        if (mainProvider.authModel!.status!) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomPage()),
                              (Route<dynamic> route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text("Username or Password not found")),
                          );
                        }
                      });
                      return;
                    } else {
                      log("sdsd");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Text(
                      'login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
