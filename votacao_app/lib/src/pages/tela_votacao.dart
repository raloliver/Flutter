import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:votacao_app/src/pages/addDados.dart';



class Principal extends StatefulWidget {
   String dados;
   Principal({Key key, Key key2, @required this.dados}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  
   
   //Assets
   AssetImage url = AssetImage("lib/assets/person.png");
   
   
   bool _esquerdo = false;
   bool _direita = false;
  
    //Cores
   Color likeNormal = Color(0xFFdfe6e9);
   Color likeRealce = Color(0xFF0984e3);

   List<Candidato> listaCandidatos = [];



  int _counter = 0;

  void _incrementCounter(){
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
  }


Future<StreamSubscription<Event>> getStream() async {

    StreamSubscription<Event> subscription = FirebaseDatabase.instance
    .reference()
    .child("Candidatos")
    .onValue
    .listen((Event event){
      Map<dynamic, dynamic> map = event.snapshot.value;
        
      });
  
    return subscription;
  }

  @override
  Widget build(BuildContext context) {
      
     List<ClicksPerYear> contagem(){
        return [
        new ClicksPerYear('', 0 , Colors.red),
        new ClicksPerYear('', 0, Colors.yellow),
      ];
     }

      var series = [
      new charts.Series(
        domainFn: (ClicksPerYear clickData, _) => clickData.year,
        measureFn: (ClicksPerYear clickData, _) => clickData.clicks,
        colorFn: (ClicksPerYear clickData, _) => clickData.color,
        id: 'Clicks',
        data: contagem(),
      ),
    ];
    var chart = new charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );

   
    List<dynamic> map = jsonDecode(widget.dados);
    map.asMap().forEach((index, value){
      listaCandidatos.add(
        new Candidato(
          value["nome"], 
          value["imagem"], 
          value["voto"], 
          value["keyFilho"],
          value["keyPai"]
          )
      );
    });
    
    return Scaffold(
     appBar: AppBar(
       title: Text("Votação"),
     ),

     body: ListView(
      children: <Widget>[
         Column(
           children: <Widget>[
           Row(
              children: <Widget>[
                Card(
                  elevation: 1.0,
                  color: Colors.white,

                   child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 10,
                      height: 200.0,
                       child: CachedNetworkImage(
                         fit: BoxFit.cover,
                         alignment: Alignment(-.2, 0),
                          imageUrl: listaCandidatos[0].imagem,
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),

                ),

                 Card(
                  elevation: 1.0,
                  color: Colors.white,
                   child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 10,
                      height: 200.0,
                       
                        child: CachedNetworkImage(
                         fit: BoxFit.cover,
                         alignment: Alignment(-.2, 0),
                          imageUrl: listaCandidatos[1].imagem,
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                  
                ),
               
              ]
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(top: 20.0),
                   child: Container(
                    margin: EdgeInsets.only(top: 30.0),
                     child: Column(
                       children: <Widget>[
                         Text(""),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _direita = false;
                              _esquerdo = true;
                               //_esquerdo ? _clicou(1) : print("nada");
                               contagem();
                            });
                          },
                           child: Container(
                              child: Icon(Icons.thumb_up, color: _esquerdo ? likeRealce : likeNormal, size: 50.0,),
                            )
                        )
                       ],
                     ),
                     
                   ),
                 ),

                 Padding(

                   padding: const EdgeInsets.only(top: 20.0),
                   child: Container(
                     margin: EdgeInsets.only(top: 30.0),
                      child: Column(
                       children: <Widget>[
                        Text(""),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _esquerdo = false;
                              _direita = true;

                               //_direita ? _clicou(0) : print("nada");
                              
                            });
                          },
                          child: Container(
                            child: Icon(Icons.thumb_up, color: _direita ? likeRealce : likeNormal, size: 50.0,),
                          )
                        )
                       ],
                     ),
                   ),
                 )
               ],
             ),
            chartWidget,

           ],
         )

      ],
     ),
    );
  }
 
}


class ClicksPerYear {
  final String year;
  final int clicks;
  final charts.Color color;

  ClicksPerYear(this.year, this.clicks, Color color)
        : this.color = new charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
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
