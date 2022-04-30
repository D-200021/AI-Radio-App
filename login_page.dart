import 'package:ai_radio/pages/formslogin.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Login Page",
          style: TextStyle(
              color: Colors.red,
              fontFamily: 'Pacifico',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.jpeg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 25,
                    spreadRadius: 16,
                    color: Colors.black.withOpacity(0.3)),
              ],
            ),
            child: SingleChildScrollView(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                          width: 1.5, color: Colors.white.withOpacity(0.1))),
                  child: FormLogin(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
