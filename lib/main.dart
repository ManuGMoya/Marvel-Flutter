import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_flutter/providers/marvel_api_provider.dart';
import 'package:marvel_flutter/repositories/character_repository.dart';
import 'package:marvel_flutter/screens/splash_screen.dart'; // Asegúrate de importar SplashScreen
import 'package:marvel_flutter/services/api_service.dart';
import 'package:marvel_flutter/services/marvel_interceptor.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  final dio = Dio();
  dio.interceptors.add(MarvelInterceptor());
  final apiService = ApiService(dio);
  final characterRepository = CharacterRepository(apiService: apiService);
  final marvelApiProvider =
      MarvelApiProvider(characterRepository: characterRepository);

  runApp(
    ChangeNotifierProvider.value(
      value: marvelApiProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(), // Cambia HomeScreen a SplashScreen
    );
  }
}
