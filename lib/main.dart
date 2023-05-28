import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:watsappweb/firebase_options.dart';
import 'package:watsappweb/routes.dart';
import 'package:watsappweb/utils/paleta_cores.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: PaletaCores.corPrimaria,
);

void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: "Whatsapp Web",
    debugShowCheckedModeBanner: false,
    theme: temaPadrao,
    //home: Login(),
    initialRoute: "/",
    onGenerateRoute: Routes.gerarRota,
  ));
}
