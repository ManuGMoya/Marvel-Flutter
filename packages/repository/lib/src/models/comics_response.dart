import 'package:repository/src/models/comic.dart';

class ComicsResponse {
  final List<Comic> comics;
  final int total;

  ComicsResponse({required this.comics, required this.total});
}
