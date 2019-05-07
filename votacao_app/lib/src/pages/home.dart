import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';



class Principal extends StatefulWidget {
   String keyFirebase;
   Principal({Key key, @required this.keyFirebase}) : super(key: key);

  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
   //Instancia firebase
   final DatabaseReference databaseReference = FirebaseDatabase.instance.reference()
   .child("Candidatos");
   
   //Listas
    List<Item> items = List();
    List<List<Item>> guloso = List();
   
   //Assets
   AssetImage url = AssetImage("lib/assets/person.png");
   
   
   bool _esquerdo = false;
   bool _direita = false;
  
    //Cores
   Color likeNormal = Color(0xFFdfe6e9);
   Color likeRealce = Color(0xFF0984e3);

   



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
    _onLoadView();
  
  }

  _clicou(int lado){
    String key = items[0].key;
   
    if(lado == 0){ //direto
    
       try{
     
       int contagem =  items[1].votos;
       contagem += 1;
       
        databaseReference.child(key).set(
            [{
            'imagem': items[1].imagem,
            'nome': items[1].nome,
            'idDuelo': items[1].nome,
            'votos': contagem,
            'key' : items[1].key
          },
            {
          'imagem': items[0].imagem,
            'nome': items[0].nome,
            'idDuelo': items[0].idDuelo,
            'votos': items[0].votos,
            'key' : items[0].key
            }]
          );

    } catch(e){ 
           
      print("Error ao salvar dados ${e}");
    }

    }else{ // esquerod

    int contagem =  items[0].votos;
       contagem += 1;
       try{
            databaseReference.child(key).set(
              [{
              'imagem': items[1].imagem,
              'nome': items[1].nome,
              'idDuelo': items[1].idDuelo,
              'votos': items[1].votos,
              'key' : items[1].key
            },
              {
            'imagem': items[0].imagem,
              'nome': items[0].nome,
              'idDuelo': items[0].idDuelo,
              'votos': contagem,
              'key' : items[0].key
              }]
            );


       } catch (e){
        print('${e}');
       }
     
    
    }

    
  }
  
  void _onLoadView() async{
    
    databaseReference.once().then((DataSnapshot snapshot){
       Map<dynamic, dynamic> values = snapshot.value;
          values.forEach((key, values){
            if(key == widget.keyFirebase){
              setState(() {
                  items.add(Item(
                nome: values[0]["nome"], 
                imagem: values[0]["imagem"],
                idDuelo: values[0]["idDuelo"],
                votos: values[0]["votos"],
                key:  values[0]["key"],
                ));
                 items.add(Item(
                nome: values[1]["nome"], 
                imagem: values[1]["imagem"],
                idDuelo: values[1]["idDuelo"],
                votos: values[1]["votos"],
                key:  values[1]["key"],
                ));
              });
            }

          });
          
      });
  }

  @override
  Widget build(BuildContext context) {
     
     List<ClicksPerYear> contagem(){
        return [
        new ClicksPerYear('${items[0].nome}', items[0].votos , Colors.red),
        new ClicksPerYear('${items[1].nome}', items[1].votos, Colors.yellow),
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

                  child: Hero(
                    tag: "imageLeft",
                      child: Container(
                      width: (MediaQuery.of(context).size.width / 2) - 10,
                      height: 200.0,
                       child: CachedNetworkImage(
                         fit: BoxFit.cover,
                         alignment: Alignment(-.2, 0),
                          imageUrl: "${items[0].imagem}",
                          placeholder: (context, url) => new CircularProgressIndicator(),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),

                    /*  decoration: const BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment(-.2,0),
                          image: NetworkImage('),
                          fit: BoxFit.cover
                        ),
                      ),*/

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
                        imageUrl: "${items[1].imagem}",
                        placeholder: (context, url) => new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
                     
                     
                     /*decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment(-.2,0),
                        image: NetworkImage('https://abrilveja.files.wordpress.com/2018/08/joao-amoedo-partido-novo-1162.jpg'),
                        fit: BoxFit.cover
                      ),
                    ),*/
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
                         Text("${items[0].nome}"),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _direita = false;
                              _esquerdo = true;
                               _esquerdo ? _clicou(1) : print("nada");
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
                        Text("${items[1].nome}"),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              _esquerdo = false;
                              _direita = true;

                               _direita ? _clicou(0) : print("nada");
                              
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
