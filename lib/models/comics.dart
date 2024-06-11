import 'package:marvel_flutter/models/image.dart';

class Comics {
  final int? id;
  final String? title;
  final List<DateDto>? dates;
  final Image? thumbnail;

  Comics({this.id, this.title, this.dates, this.thumbnail});

  factory Comics.fromJson(Map<String, dynamic> json) {
    return Comics(
      id: json['id'],
      title: json['title'],
      dates: (json['dates'] as List).map((i) => DateDto.fromJson(i)).toList(),
      thumbnail: Image.fromJson(json['thumbnail']),
    );
  }
}

class DateDto {
  final String? type;
  final DateTime? date;

  DateDto({this.type, this.date});

  factory DateDto.fromJson(Map<String, dynamic> json) {
    return DateDto(
      type: json['type'],
      date: DateTime.parse(json['date']),
    );
  }
}
