import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/detail/detail_bloc.dart';
import '../bloc/detail/detail_event.dart';
import '../bloc/detail/detail_state.dart';
import '../models/comic.dart';

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
      appBar: AppBar(title: const Text('Character Detail')),
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index < state.comics.length) {
                        return ComicItem(state.comics[index]);
                      } else if (BlocProvider.of<DetailBloc>(context)
                          .hasMoreComics) {
                        return const ComicSkeleton();
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                    childCount: state.comics.length + 1,
                  ),
                ),
              ],
            );
          } else if (state is DetailError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class ComicItem extends StatelessWidget {
  final Comic comic;

  const ComicItem(this.comic, {super.key});

  @override
  Widget build(BuildContext context) {
    String dateString = comic.dates?.first.date?.toIso8601String() ?? '';
    DateTime parsedDate = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd/MM/yy').format(parsedDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              comic.title ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              formattedDate,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            if (comic.thumbnail != null)
              AspectRatio(
                aspectRatio: 1.0,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/logo.png',
                  image:
                      "${comic.thumbnail?.path}.${comic.thumbnail?.extension}",
                  fit: BoxFit.scaleDown,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ComicSkeleton extends StatelessWidget {
  const ComicSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
