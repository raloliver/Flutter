import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:random_string/random_string.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:votacao_app/src/pages/tela_principal.dart';

class AddDados extends StatefulWidget {
  @override
  _AddDadosState createState() => _AddDadosState();
}

class _AddDadosState extends State<AddDados> with SingleTickerProviderStateMixin {
  List<Candidato> listCandidatos =[];

  bool _loading = true;
  
  String getImageAddress1;
  String getImageAddress2;
  
  Candidato candidato1 = new Candidato();
  Candidato candidato2 = new Candidato();
  
  StorageReference referenceImage1 = FirebaseStorage.instance.ref();
  StorageReference referenceImage2 = FirebaseStorage.instance.ref();
  final DatabaseReference databaseReferenceUsuario = FirebaseDatabase.instance.reference();
  


  bool _upLoad = false;

  File _imageFile1;
  File _imageFile2;

  String _downloadUrl;

  final inputPrimeiroNome = TextEditingController();
  final inputSegundoNome = TextEditingController();


  Future getImage (bool isCamera, int numero) async {
    File image1;
    File image2;
    if(isCamera){
      try{
        //image = await ImagePicker.pickImage(source: ImageSource.camera);
      } catch(e){
        print(e);
      }
    }else {
      if(numero == 1){
        try{
          
          image1 = await ImagePicker.pickImage(source: ImageSource.gallery);
          setState(() {

            _imageFile1 = image1;
        
          });
        } catch(e){
          print(e);
        }
      }else if(numero == 2){
         try{
          
          image2 = await ImagePicker.pickImage(source: ImageSource.gallery);
          setState(() {

            _imageFile2 = image2;
        
          });
        } catch(e){
          print(e);
        }
      }
    }
    
  }


  Future upLoadImage() async{
    
   if(_imageFile1 != null && _imageFile2 != null){
        
        StorageUploadTask uploadTask1 = referenceImage1.child(randomAlphaNumeric(30)).putFile(_imageFile1);
        StorageUploadTask uploadTask2 = referenceImage1.child(randomAlphaNumeric(30)).putFile(_imageFile2);
        String imageAddress1 = await (await uploadTask1.onComplete ).ref.getDownloadURL();
        String imageAddress2 = await (await uploadTask2.onComplete ).ref.getDownloadURL();
        
     
        this.candidato1.votos = 0;
        this.candidato1.imagem = imageAddress1.toString();
        this.candidato1.nome = this.inputPrimeiroNome.text;

        this.candidato2.votos = 0;
        this.candidato2.imagem = imageAddress2;
        this.candidato2.nome = this.inputSegundoNome.text;


         handleSubmit();
     
        setState(() {
          _upLoad = true;
        
        });
    }

    
 
  }
 Future handleSubmit() async {

    try{
      
      DatabaseReference userAdd1 = databaseReferenceUsuario.child("Candidatos").push();
      DatabaseReference userAdd2 = databaseReferenceUsuario.child("Candidatos");
      

      //userAdd1.child("Candiddato").set("{${userAdd1.push().key} ${candidato1.toJson()}}");
      userAdd1.push().set(candidato1.toJson());
      userAdd1.push().set(candidato2.toJson());

    } catch(e){ 
           
      print("Error ao salvar dados ${e}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: ListView(
        children: <Widget>[
           Center(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                       onTap: (){
                         getImage(false, 1);
                       },
                       child: Card(
                          elevation: 1.0,
                          color: Colors.white,
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 2) -10,
                            height: 200,
                            
                            child: _imageFile1 == null ? _imageDefault(context): Image.file(_imageFile1, height: 300.0, width: 300.0, fit: BoxFit.cover,),
                            //child : _imageFile == null ? Container() : Image.file(_imageFile, height: 300.0, width: 300.0,),

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:TextField(
                          decoration: InputDecoration(
                            hintText: 'Entre com o primeiro nome'

                          ),
                          controller: inputPrimeiroNome,
                        )
                      
                      ),

                      GestureDetector(
                       onTap: (){
                         getImage(false, 2);
                       },
                       child: Card(
                          elevation: 1.0,
                          color: Colors.white,
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 2) -10,
                            height: 200,
                            
                            child: _imageFile2 == null ? _imageDefault(context): Image.file(_imageFile2, height: 300.0, width: 300.0, fit: BoxFit.cover,),
                            //child : _imageFile == null ? Container() : Image.file(_imageFile, height: 300.0, width: 300.0,),

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:TextField(
                          decoration: InputDecoration(
                            hintText: 'Entre com o segundo nome'
                          ),
                          controller: inputSegundoNome,
                        )
                        
                      )
                     
                    ],
                  ),
                )
            
              ],
              
          ),
          
        ),

        ],
        
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        backgroundColor: Colors.green,
        onPressed: (){
          
          if(inputPrimeiroNome.text == "" || inputSegundoNome.text == "" || _imageFile1 == null || _imageFile2 == null ){
           _showDialog(context);
          }else{
          upLoadImage();
          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new Enquete(),
          );
          Navigator.of(context).push(route);
          }
        },
      ),
    );
  }

  
  Widget _imageDefault(BuildContext context){
   return new Icon(
     Icons.add_a_photo,
  
    size: 80.0,
   );
  }
}

void _showDialog(BuildContext context){
   SweetAlert.show(context,
      title: "Erro ao salvar",
      subtitle: "Preencha todos os campos",
      style: SweetAlertStyle.error);
}

class Candidato {
  String imagem;
  String nome;
  String key;
  int votos = 0;

  Candidato();
  Candidato.fromSnapshot(DataSnapshot snapshot)
    :key = snapshot.key,
    nome    = snapshot.value["nome"],
    imagem  = snapshot.value["imagem"],
    votos   = snapshot.value["votos"];

    toJson(){
      return{
        "nome" : nome,
        "imagem": imagem,
        "votos": votos,
      };
    }

}
