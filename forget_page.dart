import 'package:ai_radio/pages/forget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordUI extends StatefulWidget {
  const ForgetPasswordUI ({Key key}) : super(key: key);

  @override
  _ForgetPasswordUIState createState() => _ForgetPasswordUIState();
}

class _ForgetPasswordUIState extends State<ForgetPasswordUI > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Reset Password",
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
                  child: ForgetPassword1(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
