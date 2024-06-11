import 'package:equatable/equatable.dart';

abstract class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

class GetCharacterDetail extends DetailEvent {
  final int id;

  const GetCharacterDetail(this.id);

  @override
  List<Object> get props => [id];
}

class GetCharacterComics extends DetailEvent {
  final int characterId;

  const GetCharacterComics(this.characterId);

  @override
  List<Object> get props => [characterId];
}
