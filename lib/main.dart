import 'package:conf_call/resources/auth_method.dart';
import 'package:conf_call/screens/home_screen.dart';
import 'package:conf_call/screens/login_screen.dart';
import 'package:conf_call/screens/video_call_screen.dart';
import 'package:conf_call/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      routes: {
        LoginScreen.routeName : (context) => LoginScreen(),
        HomeScreen.routeName : (context) => HomeScreen(),
        VideoCallScreen.routeName : (context) => VideoCallScreen(),
      },
      home:  StreamBuilder(
          stream: AuthMethods().authChanges,
          builder:(context,snapshop){
            if(snapshop.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(snapshop.hasData){
              return const HomeScreen();
            }
            return  LoginScreen();
          }),
    );
  }
}


