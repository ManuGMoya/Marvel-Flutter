import 'package:equatable/equatable.dart';

abstract class MarvelEvent extends Equatable {
  const MarvelEvent();

  @override
  List<Object> get props => [];
}

class FetchCharacters extends MarvelEvent {
  final int start;
  final int count;

  const FetchCharacters(this.start, this.count);

  @override
  List<Object> get props => [start, count];
}
