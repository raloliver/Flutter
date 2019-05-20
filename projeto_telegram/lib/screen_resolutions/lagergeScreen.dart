
import 'package:flutter_web/material.dart';
import 'package:projeto_telegram/conversas/flutterando.dart';
class Large_Screen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tela_Principal();
  }

}

class Tela_Principal extends State<Large_Screen>{
  bool isEnable = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return large_screen(context);
  }



Widget large_screen(BuildContext context){
   return Padding(
     padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * .1, right: MediaQuery.of(context).size.width * .1),
        child: Scaffold(
          appBar:  appBar_large(context),
          body: Container(
              color: Colors.white,
              child: Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                        child: sideLeft(context,  MediaQuery.of(context).size.width * .266, MediaQuery.of(context).size.height - 50),
                    ),
                    Flexible(
                    flex: 2,
                        child: sideRight()
                    ),
                          ],
                    ),
               ),
     ),
   );
}


  Widget sideRight(){
    return isEnable ?  Fluterando_Chat() : Center(child: Text("Selecione um chat para começar a conversar", style: TextStyle(fontSize: 20, color: Colors.grey,),),);
  }

  Widget sideLeft(BuildContext context, width, height){
    return  Row(
                children: <Widget>[
                  Container(
                     decoration: new BoxDecoration(
                       color: Colors.white,
                        border: new Border(right: 
                          BorderSide(
                            color: Color(0xFF9e9e9e).withOpacity(0.3),
                            width: 2.0,
                      
    )                        )
                      ),
                    width: width,
                    height: height,
                    child: ListView(
                      children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: Material(
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                                hintText: "Pesquisar"
                              ) ,
                            )
                          )
                       ),
                       InkWell(
                        onTap: (){setState(() {
                          isEnable = true;
                        });},
                        child: Container(
                          color: isEnable ? Color(0xFF5682a3) : Colors.white,
                          child: ListTile(
                            
                             leading: CircleAvatar(
                              backgroundColor: Theme.of(context).dividerColor,
                              backgroundImage: NetworkImage(
                                "https://i.imgur.com/bmGT3iK.jpg",
                              ),
                            ),
                             title: Text("Flutterando"),
                              subtitle: Text("Ai mano, o flutter domina."),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 0, bottom: 5),
                                     child: Text("18:34", style: TextStyle(fontSize: 12)),
                                  ),
                                  Container(
                                
                                    decoration: new BoxDecoration(
                                     color: Colors.green,
                                     borderRadius: new BorderRadiusDirectional.circular(10.0)
                                    ),
                                    child: new Padding(
                                      padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                                      child:  Text("1", style: TextStyle(fontSize: 12, color: Colors.white),),
                                    ),
                                  )
                                ],
                              ),
                           ),
                        ),
                       ),
                        InkWell(
                           onTap: (){print("clicou");},
                           child: ListTile(
                           leading: CircleAvatar(
                            backgroundColor: Theme.of(context).dividerColor,
                            backgroundImage: NetworkImage(
                              "https://annemariesegal.files.wordpress.com/2017/06/img_0422-linkedin-size-smiling-man-in-suit.png?w=640",
                            ),
                          ),
                           title: Text("José Ricardo"),
                            subtitle: Text("Flutterando?"),
                            trailing: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 0, bottom: 5),
                                   child: Text("18:34", style: TextStyle(fontSize: 12)),
                                ),
                                Container(
                              
                                  decoration: new BoxDecoration(
                                   color: Colors.grey,
                                   borderRadius: new BorderRadiusDirectional.circular(10.0)
                                  ),
                                  child: new Padding(
                                    padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                                    child:  Text("8", style: TextStyle(fontSize: 12, color: Colors.white),),
                                  ),
                                )
                              ],
                            ),
                       ),
                        ),
                      ],
                  
                    ),
                  )
                ],
              );
  }

 



Widget appBar_large(BuildContext context){
  return new  AppBar(
           elevation: 0.0,
           backgroundColor: Color(0xFF5682a3),
           leading: IconButton(icon: Icon(Icons.menu), onPressed: (){
             
           }),
           
           );
}


}
