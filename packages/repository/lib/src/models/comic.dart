import 'package:repository/src/models/image.dart';

class Comic {
  final int? id;
  final String? title;
  final List<DateDto>? dates;
  final Image? thumbnail;

  Comic({this.id, this.title, this.dates, this.thumbnail});

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
}

class DateDto {
  final String? type;
  final DateTime? date;

  DateDto({this.type, this.date});

  factory DateDto.fromJson(Map<String, dynamic> json) {
    return DateDto(
      type: json['type'] as String?,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
