import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/marvel_bloc.dart';
import '../bloc/marvel_event.dart';
import '../bloc/marvel_state.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<MarvelBloc>(context).add(const FetchCharacters(0, 20));
    });
  }

  void navigateToHomeScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<MarvelBloc, MarvelState>(
          builder: (context, state) {
            if (state is MarvelLoading) {
              return RotationTransition(
                turns: _controller,
                child: Image.asset('assets/logo.png'),
              );
            } else if (state is MarvelLoaded) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                navigateToHomeScreen();
              });
              return const SizedBox.shrink(); // Return an empty widget
            } else {
              return const Text('Error');
            }
          },
        ),
      ),
    );
  }
}
