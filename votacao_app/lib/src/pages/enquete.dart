
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:votacao_app/src/pages/addDados.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:votacao_app/src/pages/home.dart';
import 'package:animated_card/animated_card.dart';

class Enquete extends StatefulWidget {
  @override
  _EnqueteState createState() => _EnqueteState();
}

class _EnqueteState extends State<Enquete>{
  TabController controller;
  AppLifecycleState _appLifecycleState;


  List _bottomItems = [
    {"icon": Icons.home},
    {"icon": Icons.people},

  ];
  int _currentTab = 0;

  List<Item> items = List();
  List<List<Item>> guloso = List();


  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Candidatos");
  Item item;
 

  @override
  void initState() {
    //handleSubmit();
    super.initState();
    _onLoadView();
    databaseReference.onChildAdded.listen(_onEntryAdded);

    
  }
  _onEntryAdded(Event event){
        var values = event.snapshot.value;
        var idKey = event.snapshot.key;
        
        print("Key: ${idKey}");

        items.add(Item(
          nome: values[0]["nome"], 
          imagem: values[0]["imagem"],
          idDuelo: values[0]["idDuelo"],
          votos: values[0]["votos"],
          key:  values[0]["key"]
          ));
         items.add(Item(
          nome: values[1]["nome"], 
          imagem: values[1]["imagem"],
          idDuelo: values[1]["idDuelo"],
          votos: values[1]["votos"],
          key:  values[1]["key"]
          ));
        guloso.clear();
        guloso.add(items);
  
  }
  @override
  void dispose(){
 

    super.dispose();
  }
 

  _onLoadView() async {
 
    databaseReference.once().then((DataSnapshot snapshot){
      var idKey = snapshot.key;
      Map<dynamic, dynamic> values = snapshot.value;
 
      values.forEach((key, values){
        
        
         items.add(Item(
          nome: values[1]["nome"], 
          imagem: values[1]["imagem"],
          idDuelo: values[1]["idDuelo"],
          votos: values[1]["votos"],
          key:  values[1]["key"],
          ));
      });

     /* values.forEach((key, values){
         user1 = new Item();
         user2 = new Item();

         user1.idDuelo = values[0]['idDuelo'];
         user1.imagem = values[0]['imagem'];
         user1.nome = values[0]['nome'];
         user1.votos = values[0]['votos'];

         user2.idDuelo = values[1]['idDuelo'];
         user2.imagem = values[1]['imagem'];
         user2.nome = values[1]['nome'];
         user2.votos = values[1]['votos'];

         items.add(user1);
         items.add(user2);
         
      });*/
     
    });
    guloso.add(items);
  }
  Future handleSubmit() async {
    try{
      //databaseReference.push().set(item.toJson());
    } catch(e){
      print("Error ao salvar dados ${e}");
    }
  }

 _pushRemove(int index){
   String key = guloso[index][0].key;
   databaseReference.child(key).remove();
 }
 
  @override
  Widget build(BuildContext context) {
   return new Scaffold(
     bottomNavigationBar: _buildBottomNavigation(context),
     body: Column(
       children: <Widget>[
          _currentTab == 0 ? listaContainer() 
            : MaterialApp(
            
          ),
       ],
     ),

     floatingActionButton: FloatingActionButton(
       child: Icon(Icons.add),
       onPressed: (){
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new AddDados(),
          );
          Navigator.of(context).push(route);
       },
     ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   );
  
  }


  Widget listaContainer(){
    if(guloso.isEmpty){
      return new Container(
        child: Text("Nenhum Item"),
      );
    }else{
      return new Expanded(
    
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: new Column(
            children: <Widget>[
            Flexible(
                  child: FirebaseAnimatedList(
                      query: databaseReference,
                      itemBuilder: (_, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                            return new Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    itemCount: listadeCandidatos().length,
                                    itemBuilder: (BuildContext ctxt, int index){
                                      return AnimatedCard(
                                        direction: AnimatedCardDirection.right,
                                        initDelay: Duration(microseconds: 0),
                                        duration: Duration(seconds: 1),
                                        child: listadeCandidatos()[index],
                                        onRemove: () => _pushRemove(index),
                                        );
                                    }

                                  )
                              );
                          },
                        ),
                ),
            ],
          ),
        ),
      );
    }
  }

  List<Widget> listadeCandidatos(){
    List<GestureDetector> listaCandidatos = [];

    for(int linha = 0; linha < guloso.length; linha++){
    /*print(
          Item(
            nome: guloso[linha][linha].nome,
            idDuelo: guloso[linha][linha].idDuelo,
            imagem: guloso[linha][linha].imagem,
            votos: guloso[linha][linha].votos
           ).toJson()
      );*/

      listaCandidatos.add(new GestureDetector(
        onTap: (){
          String keyID =  guloso[linha][linha].key;
             var route = new MaterialPageRoute(
             builder: (BuildContext context) =>
                new Principal(keyFirebase: keyID),
               );
              Navigator.of(context).push(route);
        },
        child: Center(
          
          child: Container(
            
             child: Card(
               elevation: 1.0,
               child: Container(
            
                padding: EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width - 20.0,
                height: 120.0,
                child: Row(
                  children: <Widget>[
                    
                    Expanded(
                    
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                  
                                  Hero(
                                    tag: "imageLeft",
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        foregroundColor: Colors.black,
                                        backgroundImage: NetworkImage(guloso[linha][0].imagem),
                                        radius: 35.0,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                        padding: EdgeInsets.only(right: 0.0),
                                        child: Text("%${guloso[linha][0].votos}",
                                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.red),
                                        
                                          ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.only(left: 0.0),
                                    child: Text("${guloso[linha][1].votos}%",
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.red),
                                    
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.blueAccent,
                                      foregroundColor: Colors.black,
                                      backgroundImage: NetworkImage(guloso[linha][1].imagem),
                                      radius: 35.0,
                                    ),
                                  ),
                                  ],
                                ),
                                 
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 90.0),
                                child: new Text("${guloso[linha][0].nome}"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: new Text("${guloso[linha][1].nome}"),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
               ),
             ),
          ),
        ),
       
        ),
       
      );
    }
    return listaCandidatos;
  } 

  Widget screenEmpty(BuildContext context){
    return new Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         
         Center(
           child: Text("Nenhum item"),
         )
        ],
      ),
    );
  }
  _buildBottomNavigation(BuildContext context){
    var _items = <BottomNavigationBarItem>[];
    for(var item in _bottomItems){
      _items.add(new BottomNavigationBarItem(
        icon: new Icon(item['icon']),
        title: new Text(''),
      ));
    }
    return new BottomNavigationBar(
      currentIndex: _currentTab,
      items: _items,
      onTap: (index){
        setState(() {
          _currentTab = index;
        });
      },
    );
  }
}

class Item {
  String imagem;
  String nome;
  String key;
  String idDuelo;
  int votos;

  Item({this.imagem, this.nome, this.idDuelo, this.votos, this.key});
  
  

    toJson(){
      return{
        "nome" : nome,
        "imagem": imagem,
        "idDuelo": idDuelo,
        "votos": votos,
      };
    }

}

