import 'package:repository/src/models/image.dart';

/// Represents a Comic in the Marvel Universe.
///
/// Each `Comic` instance has an [id], a [title], a list of [dates] which
/// are `DateDto` instances, and a [thumbnail] which is an `Image` instance.
class Comic {
  /// Creates a new `Comic` instance.
  ///
  /// All parameters are optional.
  Comic({this.id, this.title, this.dates, this.thumbnail});

  /// Creates a new `Comic` instance from a map.
  ///
  /// This factory constructor allows for easy deserialization from JSON.
  factory Comic.fromJson(Map<String, dynamic> json) {
    return Comic(
      id: json['id'] as int?,
      title: json['title'] as String?,
      dates: (json['dates'] as List)
          .map((i) => DateDto.fromJson(i as Map<String, dynamic>))
          .toList(),
      thumbnail: Image.fromJson(json['thumbnail'] as Map<String, dynamic>),
    );
  }

  /// The unique ID of the comic.
  final int? id;

  /// The title of the comic.
  final String? title;

  /// The list of dates related to the comic.
  final List<DateDto>? dates;

  /// The thumbnail image of the comic.
  final Image? thumbnail;
}

/// Represents a date related to a Comic in the Marvel Universe.
///
/// Each `DateDto` instance has a [type] and a [date].
class DateDto {
  /// Creates a new `DateDto` instance.
  ///
  /// All parameters are optional.
  DateDto({this.type, this.date});

  /// Creates a new `DateDto` instance from a map.
  ///
  /// This factory constructor allows for easy deserialization from JSON.
  factory DateDto.fromJson(Map<String, dynamic> json) {
    return DateDto(
      type: json['type'] as String?,
      date: DateTime.parse(json['date'] as String),
    );
  }

  /// The type of the date.
  final String? type;

  /// The date.
  final DateTime? date;
}
