import 'package:conf_call/resources/auth_method.dart';
import 'package:conf_call/screens/home_screen.dart';
import 'package:conf_call/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Start or join a meeting",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Image.asset("assets/images/onboarding.jpg")),
          CustomButton(text: "Google Sign in",onPressed: ()async{
            AsyncSnapshot<bool> res = _authMethods.signInWithGoogle(context) as AsyncSnapshot<bool>  ;
            if(res.data!){
              Navigator.pushNamed(context, HomeScreen.routeName);
            }
          },),
        ],
      ),
    );
  }
}
