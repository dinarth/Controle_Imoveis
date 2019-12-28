import 'package:cloud_firestore/cloud_firestore.dart' as prefix0;
import 'package:controle_lote/login_screen.dart';
import 'package:controle_lote/model/Usuario.dart';
import 'package:controle_lote/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:controle_lote/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScopedModel<Usuario>(
      model: Usuario(),
      child: Usuario().isLoggedIn() ?  MaterialApp(title: "Controle de Terrenos", home: Home()) :
      MaterialApp(title: "Controle de Terrenos", home: LoginScreen()),
    );
  }
}

/*
void main() async{



  runApp(MaterialApp(
      home: LoginScreen(),
    )//MaterialApp
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


 */
