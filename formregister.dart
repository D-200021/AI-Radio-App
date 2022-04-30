import 'package:ai_radio/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
class FormRegister extends StatefulWidget {
  FormRegister({Key key}) : super(key: key);

  @override
  _FormRegisterState createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  String email = '';
  String password = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _securetext = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          children: <Widget>[
            Form(
              child: TextFormField(
                onChanged: (val) {
                  setState(() {});
                },
                controller: emailController,
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
              height: 20,
            ),
            Form(
                child: TextFormField(
              onChanged: (val) {
                setState(() {});
              },
              obscureText: _securetext,
              controller: passwordController,
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
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: emailController.text, 
                  password: passwordController.text);
                  setState(() {
                    Get.to(LoginPage());
                  });
                print(email);
                print(password);
                emailController.clear();
                passwordController.clear();
              },
              child: Text(
                "Sign up",
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("already have a account? "),
                    TextButton(
                        onPressed: () {
                          Get.to(LoginPage());
                        },
                        child: Text("Sign In"))
                  ],
                ),               
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
