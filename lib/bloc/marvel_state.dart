import 'package:equatable/equatable.dart';

import '../models/character.dart';

abstract class MarvelState extends Equatable {
  const MarvelState();

  @override
  List<Object> get props => [];
}

class MarvelInitial extends MarvelState {}

class MarvelLoading extends MarvelState {}

class MarvelLoaded extends MarvelState {
  final List<Character> characters;

  const MarvelLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}
