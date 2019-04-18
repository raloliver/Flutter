import 'package:flutter/material.dart';
import 'package:money_manager/pages/receita.dart';
import 'package:money_manager/pages/despesas.dart';
import 'package:money_manager/pages/categoria.dart';

class AlertComponentes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
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
                              onPressed: (){
                                Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Receita()));
                              },
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
                              onPressed: (){
                                 Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Despesas()));
                              },
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
                              onPressed: (){
                                 Navigator.push(context, new MaterialPageRoute(builder: (context)=> new Categoria()));
                              },
                              child: new Text("Categoria"),
                            )
                          )

                       ],
                      ),
                    ],
          );
  }
}