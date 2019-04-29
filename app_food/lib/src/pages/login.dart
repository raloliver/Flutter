import 'package:app_food/src/pages/home.dart';
import 'package:app_food/src/services/firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Login extends StatefulWidget {
 

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();
  
  FirebaseUser user;

  bool _isLoading = false;
  String _email;
  String _senha;

 bool validateAndSave(){
   final form = formKey.currentState;
   if(form.validate()){
     form.save();
     setState(() {
       _isLoading = true;
     });
     return true;
   }
   return false;
 }
  
  Future validateAndSubmit() async {
    if(validateAndSave()){
          
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        user = await _auth.signInWithEmailAndPassword(
          email: this._email,
          password: this._senha,
        );
        
        setState(() {
          _isLoading = false;
        });
        Singleton(uiid: user.uid);
        
        var route = new MaterialPageRoute(
          builder: (BuildContext context) =>
            new Home(),

        );
        Navigator.of(context).push(route);

      } catch (e) {
         _isLoading = false;
        print('Error: ${e}');
      }


    }
  }

  @override
  void initState() {
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Login"),
      ),
      body: new Container(
        child: new Form(
          key: formKey,

          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
               _isLoading ? loading() : body()
               
            ],
          ),
        ),
      ),
    );
  }


Widget body(){
  return new Center(
    child: Column(
      children: <Widget>[
        camp_email(),
        campo_senha(),
        botao_entrar(),
      ],
    ),
  );
}

Widget camp_email(){

    return new Padding(

      padding: EdgeInsets.all(20.0),

      child: Material(
        elevation: 5.0,
            child: TextFormField(
            decoration: new InputDecoration(
              hintText: 'Email',
               prefixIcon: Icon(Icons.email)
              ),
            validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) => _email = value,
        
        ),
      ),

    );
  }



  Widget campo_senha(){
    return new Padding(

      padding: EdgeInsets.all(20.0),

      child: Material(
        elevation: 5.0,
            child: TextFormField(
                decoration: new InputDecoration(
                    hintText: 'Senha',
                    prefixIcon: Icon(Icons.lock)
                 ),
                obscureText: true,
                validator: (value) => value.isEmpty ? 'Password cant\'t be empty': null,
                onSaved: (value) => _senha = value,
             ),

      ),

    );

  }

  

  Widget botao_entrar(){

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: new RaisedButton(
          child: new Text('Login',
                     style: TextStyle(fontSize: 20.0),
                    
                  ),
            color: Colors.blue,
            onPressed: validateAndSubmit,
        ),
    );
  }
  
  Widget loading(){
    return new Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        )
      ],
    );
  }
}