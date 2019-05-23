import 'package:flutter_web/material.dart';
import 'package:projeto_telegram/conversas/flutterando.dart';
import 'package:flare_dart/actor.dart';
import 'package:projeto_telegram/screen_resolutions/lagergeScreen.dart';
import 'package:projeto_telegram/util/responsive_widget.dart.dart';



class HomePage extends StatefulWidget {
  @override
  Tela_Inicial createState() {
    // TODO: implement createState
    return new Tela_Inicial();
  }


}

class Tela_Inicial extends State<HomePage>{

 
  @override
  Widget build(BuildContext context) {
      return Material(
        color: Color(0xffdfe6e9),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ResponsiveWidget.isLargeScreen(context) ?
             ResponsiveWidget(
              largeScreen: Large_Screen(),
              )
              : null,
        ),
        );
        
  }

}