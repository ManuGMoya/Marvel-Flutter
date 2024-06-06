import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/marvel_api_provider.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MarvelApiProvider>(context, listen: false).fetchCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marvel Characters')),
      body: Consumer<MarvelApiProvider>(
        builder: (context, marvelApi, child) {
          return GridView.builder(
            itemCount: marvelApi.characters.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharacterDetailScreen(
                          character: marvelApi.characters[index]),
                    ),
                  );
                },
                child: Image.network(
                  "${marvelApi.characters[index].thumbnail?.path}"
                  ".${marvelApi.characters[index].thumbnail?.extension}",
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Text('No se pudo cargar la imagen');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
