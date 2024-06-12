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

class FetchCharacterComics extends DetailEvent {
  final int characterId;
  final int start;
  final int count;

  const FetchCharacterComics(this.characterId, this.start, this.count);

  @override
  List<Object> get props => [characterId, start, count];
}
