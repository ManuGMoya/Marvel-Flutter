import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel_flutter/bloc/detail/detail_bloc.dart';
import 'package:marvel_flutter/bloc/detail/detail_event.dart';
import 'package:marvel_flutter/bloc/home/home_bloc.dart';
import 'package:marvel_flutter/screens/detail_screen.dart';
import 'package:repository/repository.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<DetailBloc>(
              create: (context) => DetailBloc(
                characterRepository:
                    BlocProvider.of<HomeBloc>(context).characterRepository,
              )..add(GetCharacterDetail(character.id ?? -1)),
              child: CharacterDetailScreen(characterId: character.id ?? -1),
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: CachedNetworkImage(
                  imageUrl: "${character.thumbnail?.path}"
                      ".${character.thumbnail?.extension}",
                  placeholder: (context, url) => const AspectRatio(
                    aspectRatio: 1.0,
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              title: Text("${character.name}"),
              subtitle: Text(AppLocalizations.of(context)
                  .comicsCount(character.comics ?? 0)),
            ),
          ],
        ),
      ),
    );
  }
}
