import 'dart:convert';

import 'package:books_projeto/bloc/HomePageEvent.dart';
import 'package:books_projeto/bloc/HomePageState.dart';
import 'package:books_projeto/bloc/home_page_bloc.dart';
import 'package:books_projeto/home/models.dart';
import 'package:books_projeto/widgets/book_widget.dart';
import 'package:books_projeto/widgets/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc bloc = HomePageBloc(repository: Repository());
  HomePageStateSuccess data;

  List<String> categoraias = [
    "Android",
    "Java",
    "Historia",
    "Ciências",
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
            Container(
              height: 80,
              width: double.infinity,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categoraias.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 6, right: 6),
                    child: GestureDetector(
                      onTap: () {
                        _selectedIndex = index;
                        setState(() {});
                      },
                      child: Chip(
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                        backgroundColor: index == _selectedIndex
                            ? Colors.blue
                            : Colors.grey[200],
                        label: Text(
                          categoraias.elementAt(index),
                          style: TextStyle(
                              color: index == _selectedIndex
                                  ? Colors.white
                                  : Colors.grey[500]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Stack(
              children: <Widget>[
                listBooks(),
              ],
            )
          ],
        ),
      ],
      ),
    );
  }



Widget listBooks(){
  return  StreamBuilder<HomePageState>(
    stream: bloc.mapEventToState(HomePageEventSearch(query: "Android")),
    initialData: bloc.initialState,
    builder: (context, snapshot) {
       if (snapshot.data.props[0] == HomePageStateLoading) {
            return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                    child: Center(
                        child: CircularProgressIndicator(),
                      ),
                  ),
              );
        } else {
            data = snapshot.data;
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                    itemCount: data.books.length,
                    scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                          return BookWidget(
                              title: data.books[index].volumeInfo.title,
                              authors: data.books[index].volumeInfo.authors[0].toString(),
                              image: data.books[index].volumeInfo.imageLinks.thumbnail,
                            );
                        },
                  ),
            );
                
          }
    }
  );
}


}
