import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/marvel_bloc.dart';
import '../bloc/marvel_event.dart';
import '../bloc/marvel_state.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _nextPage = 20;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        BlocProvider.of<MarvelBloc>(context)
            .add(FetchCharacters(_nextPage, 20));
        _nextPage += 20;
      }
    });

    BlocProvider.of<MarvelBloc>(context).add(FetchCharacters(0, 20));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marvel Characters')),
      body: BlocBuilder<MarvelBloc, MarvelState>(
        builder: (context, state) {
          if (state is MarvelLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MarvelLoaded) {
            return GridView.builder(
              controller: _scrollController,
              itemCount: state.characters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailScreen(
                            character: state.characters[index]),
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
                              imageUrl:
                                  "${state.characters[index].thumbnail?.path}"
                                  ".${state.characters[index].thumbnail?.extension}",
                              placeholder: (context, url) => const AspectRatio(
                                aspectRatio: 1.0,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text("${state.characters[index].name}"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
