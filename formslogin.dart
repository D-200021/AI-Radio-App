import 'package:ai_radio/pages/displaypage.dart';
import 'package:ai_radio/pages/forget_page.dart';
import 'package:ai_radio/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:url_launcher/url_launcher.dart';

class FormLogin extends StatefulWidget {
  FormLogin({Key key}) : super(key: key);

  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  bool _securetext = true;
  String email = '';
  String password = '';
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
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onChanged: (val) {
                setState(() {
                  email = val;
                });
              },
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
          Form(
              key: _formkey1,
              child: TextFormField(
                controller: passwordcontroller,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
                obscureText: _securetext,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _securetext = !_securetext;
                        });
                      },
                      icon: Icon(Icons.remove_red_eye),
                    ),
                    labelText: "Password",
                    hintText: "Password ",
                    fillColor: Colors.white,
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Pacifico',
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              )),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailcontroller.text,
                password: passwordcontroller.text);
                setState(() {
                  Get.to(DisplayPage());
                });
              print(email);
              print(password);
              emailcontroller.clear();
              passwordcontroller.clear();
            },
            child: Text(
              "Login",
              style: TextStyle(color: Colors.black),
            ),
          ),
          // ElevatedButton(
          //     onPressed: () async {
          //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
          //         email: emailcontroller.text, 
          //         password: passwordcontroller.text);
          //         setState(() {
          //           Get.to(DisplayPage());
          //         });
          //       print(email);
          //       print(password);
                
          //     },
          //     child: Text(
          //       "Sign up",
          //       style: TextStyle(color: Colors.black),
          //     ),
          //   ),
          SizedBox(height: 50),
          Row(
            children: <Widget>[
              TextButton(onPressed: () {
                setState(() {
                  Get.to(ForgetPasswordUI());
                });
              }, child: Text("Forget Password")),
              SizedBox(width: 80),
              TextButton(
                  onPressed: () {
                    Get.to(RegisterPage());
                  },
                  child: Text("Sign Up"))
            ],
          ),
        ],
      ),
    );
  }
}
