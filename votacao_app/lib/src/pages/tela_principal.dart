
import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:votacao_app/src/pages/addDados.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:votacao_app/src/pages/tela_votacao.dart';
import 'package:animated_card/animated_card.dart';
import 'package:flare_flutter/flare_actor.dart';

class Enquete extends StatefulWidget {

  @override
  _EnqueteState createState() => _EnqueteState();
}

class _EnqueteState extends State<Enquete>{
  TabController controller;
  AppLifecycleState _appLifecycleState;
  StreamSubscription _subscriptionTodo;


  List listaKeysPais = [];
  //Lista contendo todas as chaves
  List listaKeysFilhos = [];

  List<Candidato> esquerda = [];
  List<Candidato> direito = [];
  List<dynamic> sendSecondScreen = [];
  bool _semDados = false;
  List _bottomItems = [
    {"icon": Icons.home},
    {"icon": Icons.people},

  ];
  int _currentTab = 0;




  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Candidatos");

 
  @override
  void initState() {
    super.initState();
   //databaseReference.onChildAdded.listen(_onEntryAdded);
  _onEntryAdded();
  
  }

 
 
  @override
  void dispose(){
    if(_subscriptionTodo != null){
      _subscriptionTodo.cancel();
    }
   
    super.dispose();
  }
 
 _onEntryAdded() {
   
    getStream().then((StreamSubscription s) => 
    _subscriptionTodo = s);
 
  }


 Future<StreamSubscription<Event>> getStream() async {

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
    .reference()
    .child("Candidatos")
    .onValue
    .listen((Event event){
      Map<dynamic, dynamic> map = event.snapshot.value;
          if(map != null){
              setState(() {
                  esquerda.clear();
                    direito.clear();
                    listaKeysPais.clear();
                    listaKeysFilhos.clear();

                    map.keys.forEach((i){
                    listaKeysPais.add(i.toString());
                    listaKeysFilhos.add(map[i.toString()]);
                  });
                
                  listaKeysFilhos.asMap().forEach((pos, f){
                    Map mapa = f;
                      if(listaKeysPais.length == 1){
                        _dataUnique(
                          mapa
                        );


                      }else{


                          mapa.values.toList().asMap().forEach((index, value){
                              
                              if(index == 0){
                                esquerda.add(
                                  new Candidato(value["nome"], value["imagem"], value["voto"],map.keys.toList()[index] ,mapa.keys.toList()[index])
                                );
                              }else{
                                  direito.add(
                                    new Candidato(value["nome"], value["imagem"], value["voto"],map.keys.toList()[index] ,mapa.keys.toList()[index])
                                  );
                              }

                          });


                      }

                   
                  });


              });


          }else{
            setState(() {
              _semDados = true;
            });
          }
      });
  
    return subscription;
  }

  _dataUnique(Map data){

     data.values.toList().asMap().forEach((index, value){ 

       index == 0 ? esquerda.add(new Candidato(

         value["nome"],

         value["imagem"],

         value["voto"],

         value["keyPai"],

         value["keyFilho"],

       )) : direito.add(new Candidato(

          value["nome"],

         value["imagem"],

         value["voto"],

         value["keyPai"],

         value["keyFilho"],



       ));

     });

  }

 _pushRemove(int index){

  databaseReference.child(listaKeysPais[index]).remove();
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
      if(_semDados){

          return Padding(
              padding: EdgeInsets.only(top: 20),
              child: new Container(
                height: 150,
                 child: FlareActor(
                    "assets/remove.flr", 
                    alignment:Alignment.center, 
                    fit:BoxFit.cover, 
                    animation:"move-right"
                    
                 ),
            ),
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
                                              direction: AnimatedCardDirection.top,
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
    for(int linha = 0; linha < direito.length; linha++){
      listaCandidatos.add( GestureDetector(
        onTap: (){
          sendSecondScreen.add(direito[linha]);
          sendSecondScreen.add(esquerda[linha]);
            var route = new MaterialPageRoute(
             builder: (BuildContext context) =>
              new Principal(dados: jsonEncode([esquerda[linha].toJson(),direito[linha].toJson()]))
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
                                  
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        foregroundColor: Colors.black,
                                        backgroundImage: NetworkImage(esquerda[linha].imagem),
                                        radius: 35.0,
                                      ),
                                    ),
                                  ),

                                  Padding(
                                        padding: EdgeInsets.only(right: 0.0),
                                        child: Text("",
                                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.red),
                                        
                                          ),
                                  ),


                                  Padding(
                                    padding: EdgeInsets.only(left: 0.0),
                                    child: Text("",
                                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.red),
                                    
                                    ),
                                  ),

                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        foregroundColor: Colors.black,
                                        backgroundImage: NetworkImage(direito[linha].imagem),
                                        radius: 35.0,
                                      ),
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
                                child: new Text(esquerda[linha].nome),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: new Text(direito[linha].nome),
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

class Candidato {
  String keyPai;
  String keyFilho;
  String nome;
  int voto;
  String imagem;
 

 Candidato(this.nome, this.imagem, this.voto, this.keyPai, this.keyFilho);

 Map<String, dynamic> toJson(){
   return <String, dynamic>{
     'nome' : this.nome,
     'imagem' : this.imagem,
     'voto' : this.voto,
     'keyFilho': this.keyFilho,
     'keyPai': this.keyPai
   };
 }

}

class ListaCandidatos{
  List<Candidato> candidatos = [];

}
