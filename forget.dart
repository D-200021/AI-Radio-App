import 'package:ai_radio/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:url_launcher/url_launcher.dart';

class ForgetPassword1 extends StatefulWidget {
  ForgetPassword1({Key key}) : super(key: key);

  @override
  _ForgetPassword1State createState() => _ForgetPassword1State();
}

class _ForgetPassword1State extends State<ForgetPassword1> {
  final emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: TextFormField(
              controller: emailcontroller,
              textInputAction: TextInputAction.send,
              autocorrect: false,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                fillColor: Colors.white,
                filled: true,
                hintText: "example@domain.com",
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
          
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
                setState(() {
                  Get.to(LoginPage());
                });
              emailcontroller.clear();
            },
            child: Text(
              "Reset Password",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
