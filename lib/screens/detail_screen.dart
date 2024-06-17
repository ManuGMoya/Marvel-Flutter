import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel_flutter/components/comc_skelleton.dart';
import 'package:marvel_flutter/components/comic_item.dart';

import '../bloc/detail/detail_bloc.dart';
import '../bloc/detail/detail_event.dart';
import '../bloc/detail/detail_state.dart';

class CharacterDetailScreen extends StatefulWidget {
  final int characterId;

  const CharacterDetailScreen({required this.characterId, super.key});

  @override
  CharacterDetailScreenState createState() => CharacterDetailScreenState();
}

class CharacterDetailScreenState extends State<CharacterDetailScreen> {
  final ScrollController _scrollController = ScrollController();
  int _nextPage = 20;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<DetailBloc>(context)
            .add(FetchCharacterComics(widget.characterId, _nextPage, 20));
        _nextPage += 20;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text(AppLocalizations.of(context).characterDetailsAppBarTitle)),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailSuccess) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Center(
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/logo.png',
                            image:
                                "${state.character.thumbnail?.path}.${state.character.thumbnail?.extension}",
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          state.character.name ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          state.character.description ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                if (state.comics.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < state.comics.length) {
                          return ComicItem(state.comics[index]);
                        } else if (BlocProvider.of<DetailBloc>(context)
                            .hasMoreComics) {
                          return const ComicSkeleton();
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      childCount: state.comics.length + 1,
                    ),
                  ),
                if (state.comics.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                        child: Text(
                            AppLocalizations.of(context).noComicsAvailable)),
                  ),
              ],
            );
          } else if (state is DetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).errorState(state.error)),
                  TextButton(
                    child: Text(AppLocalizations.of(context).retry),
                    onPressed: () {
                      BlocProvider.of<DetailBloc>(context)
                          .add(GetCharacterDetail(widget.characterId));
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
