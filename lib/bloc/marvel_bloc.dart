import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/character_repository.dart';
import 'marvel_event.dart';
import 'marvel_state.dart';

class MarvelBloc extends Bloc<MarvelEvent, MarvelState> {
  final CharacterRepository characterRepository;

  MarvelBloc({required this.characterRepository}) : super(MarvelInitial()) {
    on<FetchCharacters>((event, emit) async {
      emit(MarvelLoading());
      final characters =
          await characterRepository.getAllCharacters(event.start, event.count);
      emit(MarvelLoaded(characters));
    });
  }
}
