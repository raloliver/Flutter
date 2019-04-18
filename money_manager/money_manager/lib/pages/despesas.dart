import 'package:flutter/material.dart';
import 'package:money_manager/componentes.dart';

class Despesas extends StatefulWidget {
  @override
  _DespesasState createState() => _DespesasState();
}

class _DespesasState extends State<Despesas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       //Estilização toolbar
      appBar: AppBar(

        title: new Text("Despesas"),
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

                  child: new AlertComponentes(),

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