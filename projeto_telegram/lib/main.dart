import 'package:flutter_web/material.dart';
import 'package:projeto_telegram/tela_principal.dart';

main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: HomePage(),
    );
  }
  
}