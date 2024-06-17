import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:marvel_flutter/components/character_card.dart';
import 'package:marvel_flutter/components/character_skelleton.dart';
import 'package:repository/repository.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';

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
  List<Character> _characters = [];

  int _lastFailedStart = 0;
  int _lastFailedCount = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _scrollPosition = _scrollController.position.pixels;
        _lastFailedStart = _nextPage;
        _lastFailedCount = 20;
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
      appBar: AppBar(
          title: Text(AppLocalizations.of(context).homeScreenAppBarTitle)),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            _isLoading = true;
            return GridView.builder(
              controller: _scrollController,
              itemCount: _characters.length + 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                if (index >= _characters.length) {
                  return const CharacterSkeleton();
                } else {
                  return CharacterCard(character: _characters[index]);
                }
              },
            );
          } else if (state is HomeLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (_scrollController.hasClients) {
                _scrollController.jumpTo(_scrollPosition);
              }
            });
            _isLoading = false;
            _characters = state.characters;
            return GridView.builder(
              controller: _scrollController,
              itemCount: _characters.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return CharacterCard(character: _characters[index]);
              },
            );
          } else if (state is HomeError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context).errorState(state.message)),
                  TextButton(
                    child: Text(AppLocalizations.of(context).retry),
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context).add(
                          FetchCharacters(_lastFailedStart, _lastFailedCount));
                      _isLoading = true;
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text(AppLocalizations.of(context).unknownState),
            );
          }
        },
      ),
    );
  }
}
