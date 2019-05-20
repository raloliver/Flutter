import 'package:flutter_web/material.dart';
import 'package:projeto_telegram/conversas/flutterando.dart';
import 'package:projeto_telegram/responsive_widget.dart.dart';
import 'package:flare_dart/actor.dart';
import 'package:projeto_telegram/screen_resolutions/lagergeScreen.dart';
import 'package:projeto_telegram/teste.dart';



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



  




Widget medium_screen(BuildContext context){
    return  Scaffold(
           appBar: appBar_medium(context),
            body: Container(
              color: Colors.white,
            ),
        );

}



Widget appBar_small(BuildContext context){
  return new  AppBar(
           elevation: 0.0,
           backgroundColor: Color(0xFF5682a3),
           leading: Padding(padding: EdgeInsets.only(top: 11, bottom: 11,left: 10),
            child: Row(children: <Widget>[
             Image.asset("telegram-official.png",),
              
           ],),
            
           ),
           
            actions: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * .5, left: 0),
                  child: Text("Telegram"),
                  ),
                  IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),
                  IconButton(icon: Icon(Icons.menu, color: Colors.white,), onPressed: () {},),
                ],
              )
            ],
           );
}


Widget appBar_medium(BuildContext context){
  return new  AppBar(
           elevation: 0.0,
           backgroundColor: Color(0xFF5682a3),
           leading: Padding(padding: EdgeInsets.only(top: 11, bottom: 11,left: 10),
            child: Row(children: <Widget>[
             Image.asset("telegram-official.png",),
           ],),
            
           ),
           
            actions: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                  padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * .7, left: 0),
                  child: Text("Telegram"),
                  ),
                  IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {},),
                  IconButton(icon: Icon(Icons.menu, color: Colors.white,), onPressed: () {},),
                ],
              )
            ],
           );
}

}