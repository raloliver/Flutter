
import 'package:flutter_web/material.dart';

class Fluterando_Chat extends StatefulWidget {
 

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Tela_Inicial();
  }

}
class Tela_Inicial extends State<Fluterando_Chat>{
  final myController = new TextEditingController();
  String textChat;
  List<Pessoa> listaPessoa = [];
  textListener(){
   textChat = myController.text;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myController.addListener(textListener);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        top(),


          Container(
             height: MediaQuery.of(context).size.height * .6,
         
             child: Padding(
               padding: const EdgeInsets.only(left: 60),
               child: new ListView.builder(
                 itemCount: listaPessoa.length,
                 itemBuilder: (BuildContext context, int index){
                   return new   ListTile(
                               leading: CircleAvatar(
                                backgroundColor: Theme.of(context).dividerColor,
                                backgroundImage: AssetImage(
                                 listaPessoa[index].imagem,
                                ),
                              ),
                               title: Text(listaPessoa[index].nome),
                                subtitle: Text(listaPessoa[index].texto),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(top: 0, bottom: 20),
                                       child: Text("22:52:11", style: TextStyle(fontSize: 10, color: Color(0xffb2bec3))),
                                    ),
                                   
                                  ],
                                ),
                             );
                 },
               )
             ),
           ),


        bottom(context)
      ],
    );
  }

  Stack top() {
    return Stack(
        children: <Widget>[       
           Container(
                decoration: new BoxDecoration(
                color: Colors.white,
                  border: new Border(bottom: 
                    BorderSide(
                        color: Color(0xFF9e9e9e).withOpacity(0.2),
                        width: 1.0,
                    ),
                  )
              ),
              child: Row(
                children: <Widget>[
                 Padding(
                   padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                   child: Container(
                     decoration: new BoxDecoration(
                       color: Colors.white,
                       border: new Border(left: 
                        BorderSide(
                          color: Colors.blue,
                          width: 2.0
                        )
                       )
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         Padding(padding: EdgeInsets.only(left: 10, top: 5),
                          child: Text("Jacob Moura", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.w600),),
                         ),
                         Padding(padding: EdgeInsets.only(left: 10, top: 5),
                         child: Text("ACESSE NOSSO FÓRUM PARA ACOMPANHAR PERGUNTAS E RESPOSTAS ...",textAlign: TextAlign.left,),
                         ),

                       ],
                     )
                   ),
                 )
                ],
              ),
            ),
            
        ],
      );
  }

  Padding bottom(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 50,),
        child:   Column(
         children: <Widget>[
              ListTile(
              trailing: Row(
                children: <Widget>[
                  CircleAvatar(
                backgroundColor: Theme.of(context).dividerColor,
                backgroundImage: AssetImage("renato_perfil.jpeg"),
                
              ),
                SizedBox(width: 25,),
                Container(
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    border: new Border(bottom:
                      BorderSide(
                        color: Colors.blue,
                        width: 2.0
                      )
                    )
                  ),
                  width: 400,
                  height: 60,
                  child:ListTile(
                    leading:  Material(
                      color: Colors.transparent,
                              child: TextField(
                                onChanged: (text){
                                  setState(() {
                                    textChat = text;
                                  });
                                },
                               controller: myController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Escrever uma mensagem..."
                                ) ,
                              
                              )
                            ),
                    trailing: Image.asset("smille.png"),
                    
                  )
             
                 
                ),
                 CircleAvatar(
                            backgroundColor: Theme.of(context).dividerColor,
                            backgroundImage: NetworkImage(
                              "https://i.imgur.com/bmGT3iK.jpg",
                            ),
                          ),
                ],
              )
           ),
             Row(
             children: <Widget>[
               SizedBox(width: 70,), 
               IconButton(icon: Icon(Icons.file_upload)),
               IconButton(icon: Icon(Icons.photo_camera),),
               IconButton(icon: Icon(Icons.mic),),
               Image.asset("scream.png", scale: 20,),
               SizedBox(width: 10,),
               Image.asset("joy.png", scale: 30,),
               SizedBox(width: 10,),
               Image.asset("kissing_heart.png", scale: 6,),
               SizedBox(width: 10,),
               Image.asset("heart.png", scale: 45,),
               SizedBox(width: 10,),
               Image.asset("blush.png", scale:28,),
               SizedBox(width: 45,),
               
               InkWell(
                 onTap: (){
                   setState(() {
                     listaPessoa.add(new Pessoa(
                     nome: "Renato",
                     imagem: "renato_perfil.jpeg",
                     texto: textChat.toString())
                   );
                   });
                   
                 },
                 child: Text("ENVIAR", style: TextStyle(color: Colors.blueAccent, fontSize: 15, fontWeight: FontWeight.w600, fontFamily: "Roboto"),)),
              
             ],
           )    
         ],
       ),
      );
  }

  List<ListTile> conversas(){
    List<ListTile> pacote = [];
      ListTile(
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
                                      padding: EdgeInsets.only(top: 0, bottom: 20),
                                       child: Text("22:52:11", style: TextStyle(fontSize: 10, color: Color(0xffb2bec3))),
                                    ),
                                   
                                  ],
                                ),
                             );
    
  }
}

class Pessoa{
  String nome;
  String imagem;
  String texto;

  Pessoa({this.nome, this.imagem, this.texto});
}
