import 'package:flutter/material.dart';
import 'package:money_manager/componentes.dart';

class Categoria extends StatefulWidget {
  @override
  _CategoriaState createState() => _CategoriaState();
}

class _CategoriaState extends State<Categoria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //Estilização toolbar
      appBar: AppBar(

        title: new Text("Categoria"),
        backgroundColor: Colors.deepOrange,
        centerTitle: false,
        elevation: 0.5,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.add), onPressed: (){
            //Ao clicar no icone mais ira abrir um popUp
            showDialog(
              context: context, 
              builder: (context)=> new AlertDialog(
                title: new Text('add'),
                content: new Container(
                  height: 200.0,

                  child: new Column(
                    children: <Widget>[
                      //Linha responsavel pela receita
                      new Row(
                        children: <Widget>[

                          new Padding(
                            padding: EdgeInsets.all(1.0),
                            child: Icon(Icons.attach_money),
                          ),

                           new Padding(
                            padding: EdgeInsets.all(1.0),
                            child: new MaterialButton(
                              onPressed: (){},
                              child: new Text("Receita"),
                            )
                          )

                        ],
                      ),

                      //Botao para adicionar nova despesa
                     new Row(
                       children: <Widget>[

                         new Padding(
                           padding: EdgeInsets.all(1.0),
                           child: Icon(Icons.money_off),
                         ),

                           new Padding(
                            padding: EdgeInsets.all(1.0),
                            child: new MaterialButton(
                              onPressed: (){},
                              child: new Text("Despesas"),
                            )
                          )

                       ],
                      ),

                      //Botao para categoria
                       new Row(
                       children: <Widget>[

                         new Padding(
                           padding: EdgeInsets.all(1.0),
                           child: Icon(Icons.dashboard),
                         ),

                           new Padding(
                            padding: EdgeInsets.all(1.0),
                            child: new MaterialButton(
                              onPressed: (){},
                              child: new Text("Categoria"),
                            )
                          )

                       ],
                      ),
                    ],
                  ),

                ),
            ));
          })
        ],

      ),


      //Navigation Bar
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            
            Expanded(
              child: ListTile(
                title: new Text('Balanço:'),
                subtitle: new Text('R\$720'),
              ),
            ),

             Expanded(
              child: ListTile(
                title: new Text('Despesa:'),
                subtitle: new Text('R\$230', style: TextStyle(color: Colors.red),),
              ),
            ),

             Expanded(
              child: new IconButton(icon: Icon(Icons.remove_red_eye, color: Colors.deepOrange,), onPressed: (){})
            )

          ],
        ),
      ),

    );
  }
}