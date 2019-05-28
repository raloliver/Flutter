import 'package:flutter/material.dart';
import 'package:nubank_speed/pages/dashcreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset('assets/bg-intro.png', fit: BoxFit.cover,),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 30, top: 50),
                child: Image.asset('assets/logo2_white.png', width: 100,),
              ),
            
          Column(
              children: <Widget>[
                
                Container(
                  margin: EdgeInsets.only(top: height * .1),
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: Text(""" A forma mais simples de lidar com os seus gastos""",
                    style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),

                  ),
                ),


                SizedBox(height: 50,),
                
                MaterialButton(
                  onPressed: (){},
                  textColor: Colors.purple,
                  child: Container(
                    
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),

                    padding: const EdgeInsets.fromLTRB(90, 12, 90, 12),
                    child: Text("PEDIR MEU CONITE",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  
                ),


                SizedBox(height: 10,),

                MaterialButton(
                  color: Colors.transparent,
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashScreen())
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.white, width: 1),
                        top: BorderSide(color: Colors.white, width: 1),
                        left: BorderSide(color: Colors.white, width: 1),
                        right: BorderSide(color: Colors.white, width: 1)

                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0)
                      )

                    ),
                    padding: const EdgeInsets.fromLTRB(136, 12, 136, 12),
                    child: Text("LOGIN", style: TextStyle(fontSize: 15, color: Colors.white)),

                  ),
                ),

              ],
            )
            ],
          )
        ],
      ),
      
    );
  }
}