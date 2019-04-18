
import 'package:flutter/material.dart';
//Meus imports
import 'package:money_manager/pages/receita.dart';
import 'package:money_manager/pages/despesas.dart';
import 'package:money_manager/pages/categoria.dart';
import 'package:money_manager/componentes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //Codigo para pegar a largura do dispositivo
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size.width;

    return Scaffold(
      //Estilização toolbar
      appBar: AppBar(

        title: new Text("Flutter cash app"),
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
                  child: AlertComponentes(),
                 
                ),
            ));
          })
        ],

      ),

      body: new Stack(
        children: <Widget>[
          Center(
            child: ListTile(
              title: new Icon(Icons.account_balance_wallet, size: 64.0, color: Colors.grey,),
              subtitle: new Padding(padding: EdgeInsets.only(left: size / 2.8),
              child: new Text('Carteira Vazia!', style: TextStyle(fontSize: 16.0),)),
            ),
          )
        ],
      ),

      
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