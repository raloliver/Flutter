import 'package:books_projeto/bloc/home_page_bloc.dart';
import 'package:books_projeto/home/home_page.dart';
import 'package:books_projeto/widgets/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final HomePageBloc _homePage = HomePageBloc(repository: Repository());
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Books',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<HomePageBloc>(
        bloc: _homePage,
        child: HomePage()
        ),
    );
  }
}
