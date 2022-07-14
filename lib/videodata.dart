import 'dart:convert';

class VideoFields {
  static final String slno = 'slno';
  static final String video_file = 'video_file';
  static final String thumbnail_file = 'thumbnail_file';
  static final String title = 'title';
  static final String description = 'description';
  static final String category = 'category';
  static final String keywords = 'keywords';
  static final String privacystatus = 'privacystatus';

  static List<String> getFields() => [slno, video_file, thumbnail_file, title, description, category, keywords, privacystatus];
}

class Video {
  final int? slno;
  final String video_file;
  final String thumbnail_file;
  final String title;
  final String description;
  final String category;
  final String keywords;
  final String privacystatus;

  const Video({
    this.slno,
    required this.video_file,
    required this.thumbnail_file,
    required this.title,
    required this.description,
    required this.category,
    required this.keywords,
    required this.privacystatus,
});

  Map<String, dynamic> toJson() => {
    VideoFields.slno: slno,
    VideoFields.video_file: video_file,
    VideoFields.thumbnail_file: thumbnail_file,
    VideoFields.title: title,
    VideoFields.description: description,
    VideoFields.category: category,
    VideoFields.keywords: keywords,
    VideoFields.privacystatus: privacystatus,
  };

  static Video fromJson(Map<String, dynamic> json) => Video(
    slno: jsonDecode(json[VideoFields.slno]),
    video_file: json[VideoFields.video_file],
    thumbnail_file: json[VideoFields.thumbnail_file],
    title: json[VideoFields.title],
    description: json[VideoFields.description],
    category: json[VideoFields.category],
    keywords: json[VideoFields.keywords],
    privacystatus: json[VideoFields.privacystatus],
  );

}