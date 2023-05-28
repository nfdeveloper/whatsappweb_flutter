import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:watsappweb/firebase_options.dart';
import 'package:watsappweb/routes.dart';
import 'package:watsappweb/screens/login.dart';

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: "Whatsapp Web",
    debugShowCheckedModeBanner: false,
    //home: Login(),
    initialRoute: "/",
    onGenerateRoute: Routes.gerarRota,
  ));
}
