import 'package:bloc/bloc.dart';
import 'package:books_projeto/bloc/HomePageEvent.dart';
import 'package:books_projeto/bloc/HomePageState.dart';
import 'package:books_projeto/widgets/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class HomePageBloc extends Bloc<HomePageEvents, HomePageState>{
  final Repository repository;
  HomePageBloc({
   @required this.repository
  });

  @override
  // TODO: implement initialState
  HomePageState get initialState => HomePageStateLoading();

  @override
  Stream<HomePageState> mapEventToState(HomePageEvents event) async* {
    if(event is HomePageEventSearch){
      yield HomePageStateLoading();
      var query = event.query;
      var booksResult = await repository.getBooks(query);

      yield booksResult;
    }
  }

 

}