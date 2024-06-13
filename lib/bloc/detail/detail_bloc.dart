import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository/repository.dart';

import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final CharacterRepository characterRepository;
  bool hasMoreComics = true;
  List<Comic> allComics = [];

  DetailBloc({required this.characterRepository}) : super(DetailLoading()) {
    on<GetCharacterDetail>((event, emit) async {
      emit(DetailLoading());
      try {
        final character = await characterRepository.getCharacterById(event.id);
        emit(DetailSuccess(character, const []));
        add(FetchCharacterComics(event.id, 0, 20));
      } catch (e) {
        emit(DetailError(e.toString()));
      }
    });

    on<FetchCharacterComics>((event, emit) async {
      if (!hasMoreComics) return;
      try {
        final result = await characterRepository.getComicsByCharacterId(
            event.characterId, event.start, event.count);
        final comics = result.comics;
        allComics = [...allComics, ...comics];
        final total = result.total;
        if (allComics.length >= total) {
          hasMoreComics = false;
        }
        final character = (state as DetailSuccess).character;
        emit(DetailSuccess(character, allComics));
      } catch (e) {
        emit(DetailError(e.toString()));
      }
    });
  }
}
