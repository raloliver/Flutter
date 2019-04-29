import 'package:app_food/src/services/firebase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Database{
  final DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child("Usuarios");
  String key;
  String nome;
  String sobrenome;

  Database.fromSnapshot(DataSnapshot snapshot)
    : key = snapshot.key,
      nome = snapshot.value["nome"],
      sobrenome = snapshot.value["sobrenome"]; 

  Database(){
    Singleton uiid = new Singleton();
    this.key = uiid.uiid;
    this.nome = "Joaquin";
    this.sobrenome =  "Silva";

    try{
      databaseReference.child(key).set({
        'name': nome,
        'sobrenome': sobrenome
      });
    } catch(e){
      print("error ${e.message}");
    }
   
  }
}