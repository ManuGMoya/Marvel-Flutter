import 'package:flutter/material.dart';

class CharacterSkeleton extends StatelessWidget {
  const CharacterSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.grey[300],
            ),
          ),
          ListTile(
            title: Container(
              color: Colors.grey[300],
              height: 20.0,
            ),
            subtitle: Container(
              color: Colors.grey[300],
              height: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
