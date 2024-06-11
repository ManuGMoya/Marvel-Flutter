import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/character.dart';
import '../repositories/character_repository.dart';
import 'marvel_event.dart';
import 'marvel_state.dart';

class MarvelBloc extends Bloc<MarvelEvent, MarvelState> {
  final CharacterRepository characterRepository;
  List<Character> characters = [];

  MarvelBloc({required this.characterRepository}) : super(MarvelInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(MarvelLoading());
      final newCharacters = await characterRepository.getAllCharacters(event.start, event.count);
      characters = [...characters, ...newCharacters];
      emit(MarvelLoaded(characters));
    });
  }
}
