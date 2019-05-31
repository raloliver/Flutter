import 'package:books_projeto/home/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HomePageState extends Equatable{
  final String className;

  HomePageState({this.className}): super([className]);
}

class HomePageStateLoading extends HomePageState with EquatableMixinBase, EquatableMixin{
 
 @override
  // TODO: implement props
  List get props => [HomePageStateLoading];
}

class HomePageStateSuccess extends HomePageState  with EquatableMixinBase, EquatableMixin{
 final List<Book> books;
 HomePageStateSuccess({
  @required this.books
 });

  @override
  // TODO: implement props
  List get props => [HomePageStateSuccess, books];


}

class HomePageStateError extends HomePageState with EquatableMixinBase, EquatableMixin{
  final String message;
  
  HomePageStateError({
    @required this.message
  });

 @override
  // TODO: implement props
  List get props => [HomePageStateError];
}