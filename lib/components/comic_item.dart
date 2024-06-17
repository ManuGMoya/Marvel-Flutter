import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:repository/repository.dart';

class ComicItem extends StatelessWidget {
  final Comic comic;

  const ComicItem(this.comic, {super.key});

  @override
  Widget build(BuildContext context) {
    String dateString = comic.dates?.first.date?.toIso8601String() ?? '';
    DateTime parsedDate = DateTime.parse(dateString);
    String formattedDate = DateFormat('dd/MM/yy').format(parsedDate);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              comic.title ?? '',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8.0),
            Text(
              formattedDate,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8.0),
            if (comic.thumbnail != null)
              AspectRatio(
                aspectRatio: 1.0,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/logo.png',
                  image:
                      "${comic.thumbnail?.path}.${comic.thumbnail?.extension}",
                  fit: BoxFit.scaleDown,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
