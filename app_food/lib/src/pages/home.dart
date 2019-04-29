import 'package:app_food/src/services/firebase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Item item;
  List<Item> items = List();
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Usuarios");
  final formKey = new GlobalKey<FormState>();
 
 
  @override
  void initState() {
    super.initState();
    item = Item("", "");
    items.add(item);
    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  
 _onEntryAdded(Event event) {
    setState(() {
      items.add(Item.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = items.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      items[items.indexOf(old)] = Item.fromSnapshot(event.snapshot);
    });
  }

  Future handleSubmit() async {
    final FormState form = formKey.currentState;

    if(form.validate()){
      form.save();
      form.reset();
       try{
          databaseReference.push().set(item.toJson());
        } catch(e){
          print("Erro => ${e}");
        }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           new Form(
              key: formKey,
              child: body(),
               
            ),
             Flexible(
            child: FirebaseAnimatedList(
              query: databaseReference,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return new ListTile(
                  title: new Text(items[index].nome),
                  subtitle: new Text(items[index].sobrenome),
                );
              },
            ),
          ),
        ],
      ),
       
    );
  }

  Widget body(){
    return new Column(
      children: <Widget>[
        campoNome(),
        campoSobrenome(),
        botaoSalvar(),
        
      ],
    );
  }

 
  Widget campoNome(){
    return new Center(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
                child: Material(
                  elevation: 5.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                          hintText: "Nome",
                          contentPadding: EdgeInsets.all(10.0)
                         ),
                        onSaved: (val) => item.nome = val,
                        validator: (val) => val.isEmpty ? "Preencha o campo" : null,
                     ),
                 ),
          ),
    );
  }



  Widget campoSobrenome(){
    return new Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Material(
                  elevation: 5.0,
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                          hintText: "Sobrenome",
                          contentPadding: EdgeInsets.all(10.0)
                         ),
                         onSaved: (val) => item.sobrenome = val,
                        validator: (val) => val.isEmpty ? "Preencha o campo" : null,
                     ),
                 ),
          ),
    );
  }

  Widget botaoSalvar(){
    return new Center(
      child: new RaisedButton(
          child: new Text('Login',
                     style: TextStyle(fontSize: 20.0),
                    
                  ),
            color: Colors.blue,
            onPressed: handleSubmit,
        ),
    );

  }
}

class Item {
  String key;
  String nome;
  String sobrenome;

  Item(this.nome, this.sobrenome);
  Item.fromSnapshot(DataSnapshot snapshot)
    : key   = snapshot.key,
      nome = snapshot.value["nome"],
      sobrenome  = snapshot.value["sobrenome"];

    toJson(){
      return {
        "nome": nome,
        "sobrenome": sobrenome,
      };
    }
}