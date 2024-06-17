import 'package:repository/repository.dart';

/// Represents the response from the Comics API.
///
/// Each `ComicsResponse` instance has a list of [comics] and a [total] count.
class ComicsResponse {
  /// Creates a new `ComicsResponse` instance.
  ///
  /// Both parameters are required.
  ComicsResponse({required this.comics, required this.total});

  /// The list of comics in the response.
  final List<Comic> comics;

  /// The total count of comics in the response.
  final int total;
}
