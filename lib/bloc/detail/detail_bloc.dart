import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/character_repository.dart';
import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final CharacterRepository characterRepository;

  DetailBloc({required this.characterRepository}) : super(DetailLoading()) {
    on<GetCharacterDetail>((event, emit) async {
      emit(DetailLoading());
      try {
        final character = await characterRepository.getCharacterById(event.id);
        emit(DetailSuccess(character, []));
        add(GetCharacterComics(character.id!));
      } catch (e) {
        emit(DetailError(e.toString()));
      }
    });

    on<GetCharacterComics>((event, emit) async {
      try {
        final comics =
            await characterRepository.getComicsByCharacterId(event.characterId);
        final character = (state as DetailSuccess).character;
        emit(DetailSuccess(character, comics));
      } catch (e) {
        emit(DetailError(e.toString()));
      }
    });
  }
}
