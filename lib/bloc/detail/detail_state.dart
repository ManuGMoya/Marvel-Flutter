import 'package:equatable/equatable.dart';

import '../../models/character.dart';
import '../../models/comic.dart';

abstract class DetailState extends Equatable {
  const DetailState();

  @override
  List<Object> get props => [];
}

class DetailLoading extends DetailState {}

class DetailSuccess extends DetailState {
  final Character character;
  final List<Comic> comics;

  const DetailSuccess(this.character, this.comics);

  @override
  List<Object> get props => [character, comics];
}

class DetailError extends DetailState {
  final String error;

  const DetailError(this.error);

  @override
  List<Object> get props => [error];
}
