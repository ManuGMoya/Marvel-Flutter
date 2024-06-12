import 'package:equatable/equatable.dart';

import '../../models/character.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Character> characters;

  const HomeLoaded(this.characters);

  @override
  List<Object> get props => [characters];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}
