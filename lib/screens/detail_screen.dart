import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/detail/detail_bloc.dart';
import '../bloc/detail/detail_state.dart';
import '../models/comics.dart';

class CharacterDetailScreen extends StatelessWidget {
  const CharacterDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Character Detail')),
      body: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          if (state is DetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailSuccess) {
            return ListView(
              children: <Widget>[
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
                ...state.comics.map((comic) => ComicItem(comic)),
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
  final Comics comic;

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
