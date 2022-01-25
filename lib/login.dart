import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/main.dart';
import 'package:login/register.dart';
import 'package:login/start.dart';
import 'package:login/welcome.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();

  Future Signin() async {
    try {
      // this will check that the input email & password are correct
      final isvalid = formKey.currentState!.validate();
      if (!isvalid) return;
      // print(isvalid);

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordcontroller.text);
      setState(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const welcome()),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Error Ocurred")));
      print(e);
    }
  }

  errcatch() {}

  @override
  void dispose() {
    emailController.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            // form key is use the valid the multiple form feild, to access this we must have to provide global key
            key: formKey,
            child: Column(
              children: [
                // Padding(
                // padding: const EdgeInsets.all(8.0),
                Container(
                  child: Image.asset(
                    "assets/images/login.jpg",
                    fit: BoxFit.cover,
                    scale: 5,
                  ),
                ),
                // ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: "Email",
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && !EmailValidator.validate(email)
                              ? 'Enter the valid email'
                              : null),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: TextFormField(
                    controller: passwordcontroller,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value != null && value.length < 6
                        ? 'Enter min. 6 charater'
                        : null,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                    ),
                  ),
                ),
                ElevatedButton(onPressed: Signin, child: const Text("LOGIN")),
                // GestureDetector(
                // onTap: null,
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Container(
                          child: Text("Forget password? "),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => register()));
                        },
                        child: Container(
                          child: Text(
                            "New User",
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
