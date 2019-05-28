import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashScreen extends StatefulWidget {
  @override
  _DashScreenState createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
    Color background = Color(0xff8e44ad);
    double distance = 160.0;
    double initial = 0.0;

  @override
  Widget build(BuildContext context) {


    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          color: background,
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              header(),
              listBackgroundButton(),
              bottomList(),
            ],
          ),
        ),
        moveCard(),

      ],
    );

  }

  Widget header(){
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/logo-white.png", width: 50, height: 50),
              SizedBox(width: 10,),
              Text("Renato", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
            ],
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.white,)
        ],
      ),
    );
  }

  Widget listBackgroundButton(){
    return Column(
      children: <Widget>[
          
          backgroundButton(
            myText: "Me ajuda",
            myIconOne: Icons.help_outline,
            myIconTwo: Icons.keyboard_arrow_right,
            borderBottom: BorderSide(color: Colors.transparent),
            borderTop: BorderSide(
              color: Colors.white,
              width: 1,
          ),),

           backgroundButton(
            myText: "Perfil",
            myIconOne: Icons.person,
            myIconTwo: Icons.keyboard_arrow_right,
            borderBottom: BorderSide(color: Colors.transparent),
            borderTop: BorderSide(
              color: Colors.white,
              width: 1,
          ),),

           backgroundButton(
            myText: "Configurar Cartão",
            myIconOne: Icons.payment,
            myIconTwo: Icons.keyboard_arrow_right,
            borderBottom: BorderSide(color: Colors.transparent),
            borderTop: BorderSide(
              color: Colors.white,
              width: 1,
          ),),

           backgroundButton(
            myText: "Configurações do app",
            myIconOne: Icons.stay_current_portrait,
            myIconTwo: Icons.keyboard_arrow_right,
            borderBottom: BorderSide(color: Colors.white),
            borderTop: BorderSide(
              color: Colors.white,
              width: 1,
          ),),

      ],
    );
  }


  Widget backgroundButton(
   {
      String myText, 
      IconData myIconOne, 
      IconData myIconTwo, 
      BorderSide borderBottom,
      BorderSide borderTop, 
   }
   ){

    return Material(
      child: Container(
        width: 350,
        padding: const EdgeInsets.only(top: 12, bottom: 12),
        decoration: BoxDecoration(
          color: background,
          border: Border(
            top: borderTop,
            bottom: borderBottom
          )
        ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            
            Flexible(
              flex: 1,
              child: Icon(myIconOne, size: 40, color: Colors.white,),
            ),
            Flexible(
              flex: 3,
              child: Text(
                myText,
                style: TextStyle(color: Colors.white)
              ),
            ),
            Flexible(
              flex: 1,

              child: Icon(myIconTwo, color: Colors.white, size: 40,),
            )

          ],
        ),

      ),
    );
  }

  Widget bottomList(){
    return Container(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          SizedBox(width: 20,),
          containerButton(myText: "Indicar amigos", myIcon: Icons.group_add),
          containerButton(myText: "Ajustar Limite", myIcon: Icons.tune),
          containerButton(myText: "Bloquear Cartão", myIcon: Icons.lock_open),
          containerButton(myText: "Cancelar Cartão", myIcon: Icons.credit_card),
        ],
      ),
    );
  }


  Widget containerButton({String myText, IconData myIcon}){
    return Container(
      margin: EdgeInsets.only(bottom: 10, right: 10),
      padding: EdgeInsets.all(5),
      width: 120,
      decoration: new BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.2),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(myIcon, color: Colors.white,),
            Text(myText, style: TextStyle(color: Colors.white))
          ],  
        ),
      ),
    );
  }

  Widget moveCard(){
    return Stack(
      children: <Widget>[
        Positioned(
          top: distance,
          right: 5,
          child: GestureDetector(
            onPanStart: (DragStartDetails details){
              setState(() {
                distance = details.globalPosition.dy - 20;
              });
            },
            onPanUpdate: (DragUpdateDetails details){
              setState(() {
                  if(details.globalPosition.dy > 500){
                    distance = 500.0;
                  } else if (details.globalPosition.dy < 160){
                    distance = 170.0;
                  }else {
                    distance = details.globalPosition.dy - initial;
                  }
              });
            },
            child: contentCard(),
          ),
        )
      ],
    );
  }


  Widget contentCard(){
    return Card(
      elevation: 0.1,
      color: Colors.white,
      
      child: Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        height: MediaQuery.of(context).size.height * .5,
        width: MediaQuery.of(context).size.width * .96,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            
            Icon(
              Icons.monetization_on,
              size: 40,
              color: Colors.grey,
            ),

            Text("Conta", style: TextStyle(fontSize: 40),),

            Text("Saia da poupança e faça seu dinheiro render de forma justa",
              style: TextStyle(fontSize: 25,
              color: Colors.grey,
            ),),

            Material(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xff8e44ad)),
                    bottom: BorderSide(color: Color(0xff8e44ad)),
                    left: BorderSide(color: Color(0xff8e44ad)),
                    right: BorderSide(color: Color(0xff8e44ad)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text("CONHEÇA",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff8e44ad),
                        ),
                      ),
                    ),
                  ],
                )
              ),

            )
          ],
        ),
      ),
    );
  }

}