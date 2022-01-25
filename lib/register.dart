import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/login.dart';
import 'package:login/welcome.dart';

class register extends StatefulWidget {
  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final formkey2 = GlobalKey();
  final nameconroller = TextEditingController();
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();

  Future signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordcontroller.text,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => welcome()));
    } on FirebaseAuthException catch (e) {
      var error = e.toString();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error Ocurred")));
      print(e);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey2,
        child: Column(
          children: [
            Container(
              child: Image.asset("assets/images/register.jpg"),
            ),
            Container(
              child: TextFormField(
                controller: nameconroller,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    value != null ? null : 'enter the user name',
                decoration: InputDecoration(
                    labelText: "Name", prefixIcon: Icon(Icons.person)
                    // errorText: "Username cannot be null"
                    ),
              ),
            ),
            Container(
              child: TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter the valid email'
                        : null,
                decoration: InputDecoration(
                    labelText: "Email", prefixIcon: Icon(Icons.mail)),
              ),
            ),
            Container(
              child: TextFormField(
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => password != null && password.length < 6
                    ? 'Enter min. 6 charater'
                    : null,
                controller: passwordcontroller,
                decoration: InputDecoration(
                    labelText: "Password", prefixIcon: Icon(Icons.lock)),
              ),
            ),
            ElevatedButton(onPressed: signup, child: Text("SIGNUP")),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ?"),
                GestureDetector(
                    // onTap: Navigator.push(context, MaterialPageRoute(builder: (context)=>Login());),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login())),
                    child: Container(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
