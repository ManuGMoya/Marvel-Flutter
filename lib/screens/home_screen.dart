import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/detail/detail_bloc.dart';
import '../bloc/detail/detail_event.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _nextPage = 20;
  double _scrollPosition = 0.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _scrollPosition = _scrollController.position.pixels;
        BlocProvider.of<HomeBloc>(context).add(FetchCharacters(_nextPage, 20));
        _nextPage += 20;
        _isLoading = true;
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
      appBar: AppBar(title: const Text('Marvel Characters')),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(_scrollPosition);
              }
            });
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
                        builder: (context) => BlocProvider<DetailBloc>(
                          create: (context) => DetailBloc(
                            characterRepository:
                                BlocProvider.of<HomeBloc>(context)
                                    .characterRepository,
                          )..add(GetCharacterDetail(
                              state.characters[index].id ?? -1)),
                          child: const CharacterDetailScreen(),
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
