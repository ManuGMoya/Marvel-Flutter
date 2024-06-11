import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchCharacters extends HomeEvent {
  final int start;
  final int count;

  const FetchCharacters(this.start, this.count);

  @override
  List<Object> get props => [start, count];
}
