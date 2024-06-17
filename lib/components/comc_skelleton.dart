import 'package:flutter/material.dart';

class ComicSkeleton extends StatelessWidget {
  const ComicSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
