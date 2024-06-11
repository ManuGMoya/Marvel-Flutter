import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detail/detail_bloc.dart';
import '../bloc/detail/detail_state.dart';

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
            return Column(
              children: <Widget>[
                Image.network(
                  "${state.character.thumbnail?.path}"
                  ".${state.character.thumbnail?.extension}",
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Text('No se pudo cargar la imagen');
                  },
                ),
                Text(state.character.name ?? ''),
                Text(state.character.description ?? ''),
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
