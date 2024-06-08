import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_flutter/repositories/character_repository.dart';
import 'package:marvel_flutter/screens/splash_screen.dart'; // Asegúrate de importar SplashScreen
import 'package:marvel_flutter/services/api_service.dart';
import 'package:marvel_flutter/services/marvel_interceptor.dart';

import 'bloc/marvel_bloc.dart';

void main() async {
  await dotenv.load();
  final dio = Dio();
  dio.interceptors.add(MarvelInterceptor());
  final apiService = ApiService(dio);
  final characterRepository = CharacterRepository(apiService: apiService);

  runApp(
    BlocProvider(
      create: (context) => MarvelBloc(characterRepository: characterRepository),
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
