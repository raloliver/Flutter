import 'package:flutter/material.dart';
import 'package:votacao_app/src/pages/addDados.dart';
import 'package:votacao_app/src/pages/tela_principal.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Enquete(),
      },
    );
  }
  

}
