import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:books_projeto/bloc/HomePageEvent.dart';
import 'package:books_projeto/bloc/HomePageState.dart';
import 'package:books_projeto/bloc/home_page_bloc.dart';
import 'package:books_projeto/home/models.dart';
import 'package:books_projeto/widgets/book_widget.dart';
import 'package:books_projeto/widgets/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BlocDelegate{
  HomePageBloc _homePageBloc;
  List<Book> bookList = [];
  
  StreamController<int>  _streamController = new StreamController<int>();
  String cateria;

  

  List<String> categorias = [
    "Android",
    "Java",
    "Historia",
    "Ciencias",
    "Mitos",
    "Tipografia"
  ];

  int _selectedIndex = 0;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement initState
    super.initState();
   
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    // TODO: implement onTransition
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
      children: <Widget>[
          Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 24,
                ),
                Text(
                  "Browse",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 24,
                ),
                Text(
                  "Recomended",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[400]),
                )
              ],
            ),
            StreamBuilder<int>(
              stream: _streamController.stream,
              initialData: 0,
              builder: (context, snapshot) {
                return Container(
                      height: 80,
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categorias.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 6, right: 6),
                            child: GestureDetector(
                              onTap: () {
                                _streamController.add(index);
                                 _homePageBloc.dispatch(HomePageEventSearch(query: categorias[index]));
                        
                              },
                              child: Chip(
                                padding: EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                ),
                                backgroundColor: index == snapshot.data
                                    ? Colors.blue
                                    : Colors.grey[200],
                                label: Text(
                                  categorias.elementAt(index),
                                  style: TextStyle(
                                      color: index == snapshot.data
                                          ? Colors.white
                                          : Colors.grey[500]),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
              }
            ),
            Stack(
              children: <Widget>[
                listBooks(context),
              ],
            )
          ],
        ),
      ],
      ),
    );
  }



Widget listBooks(BuildContext context){
    _homePageBloc = BlocProvider.of<HomePageBloc>(context);
    _homePageBloc.dispatch(HomePageEventSearch(query: categorias[0]));
  return  BlocBuilder<HomePageEvents, HomePageState>(
    bloc: _homePageBloc,
    builder: (BuildContext context ,HomePageState snapshot) {
      if(snapshot.props[0] == HomePageStateLoading){
        return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                    child: Center(
                        child: CircularProgressIndicator(),
                      ),
                  ),
              );
       } else if(snapshot.props[0] == HomePageStateSuccess) {
           bookList = snapshot.props[1];

            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                    itemCount: bookList.length,
                    scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                          return BookWidget(
                              title: bookList[index].volumeInfo.title,
                              authors: bookList[index].volumeInfo.authors[0].toString(),
                              image: bookList[index].volumeInfo.imageLinks.thumbnail,
                            );
                        },
                  ),
            );
       }else {
         return Container(
           child: Center(
             child: Text("Erro ao conectar"),
           ),
         );
       }      
    }
  
  );
}


}

