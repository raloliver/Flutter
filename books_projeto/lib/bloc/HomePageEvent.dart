
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class HomePageEvents extends Equatable{
  HomePageEvents([List tmp = const []]) : super(tmp);
}

class HomePageEventSearch extends HomePageEvents{
  final String query;
  HomePageEventSearch({
    @required this.query
  });

  @override
  String toString() => "HomePageEventSearch";
}