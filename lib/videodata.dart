import 'dart:convert';

class VideoFields {
  static final String slno = 'slno';
  static final String title = 'title';
  static final String description = 'description';
  static final String keywords = 'keywords';
  static final String category = 'category';
  static final String thumbnail = 'thumbnail';

  static List<String> getFields() => [slno, title, description, keywords, category, thumbnail];
}

class Video {
  final int? slno;
  final String title;
  final String description;
  final String keywords;
  final String category;
  final String thumbnail;

  const Video({
    this.slno,
    required this.title,
    required this.description,
    required this.keywords,
    required this.category,
    required this.thumbnail,
});

  Map<String, dynamic> toJson() => {
    VideoFields.slno: slno,
    VideoFields.title: title,
    VideoFields.description: description,
    VideoFields.keywords: keywords,
    VideoFields.category: category,
    VideoFields.thumbnail: thumbnail,
  };

  static Video fromJson(Map<String, dynamic> json) => Video(
    slno: jsonDecode(json[VideoFields.slno]),
    title: json[VideoFields.title],
    description: json[VideoFields.description],
    keywords: json[VideoFields.keywords],
    category: json[VideoFields.category],
    thumbnail: json[VideoFields.thumbnail],
  );

}