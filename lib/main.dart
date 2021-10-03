import 'package:flutter/material.dart';
import 'package:jibli/vendeur/profile.dart';
import './home2.dart';
import 'client/client_home.dart';
import 'login/login_jibley.dart';
import 'login/login_vendeur.dart';
import 'client/profile_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
       "/login": (context)=>login(),
       "/client_home": (context)=>client_home(),
       "/login_jibley" : (context)=>login_jibley(),
        "/myhome":(context)=>MyHomePage(),
     },
      //nothing
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,

      ),
      home: OnboardingExample(),
    );
  }
}

