import 'package:e_learning_ytuploads/videodata.dart';
import 'package:gsheets/gsheets.dart';

class VideosSheetsApi{
  static const _credentials = r"""
{
  "type": "service_account",
  "project_id": "swiftload-youtube",
  "private_key_id": "23c42191cd234f10402b9d31320326133d73c6eb",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCpthBGcL5GQ5Hy\nIb62pPspkmnFeQ9FGKaM7sg2Tvxucv7QBxsXjRGBTLvtHGZ0xhyFxBBKpSfESe+8\nXxC02YDMhgQJ3Ee8i9+Cr5eX1N7ccGH0dXzqmgkTCekzgZZPZdbPX/vE9jqM345b\nSt3CKkRjr4TymV5xzIef6z1hwRvgBJysO2jdzlvtPFEfNLN13RFYtlynzhybjNhA\nzqwEA/5VVTe4USobnYhMwMDgMYf1K2W4H6tY5+phztEfGAI1EzE5g0J8WQYwdl0u\n1oTOciqf7h8ZzqYeByFAK1BEpFWEq3izAAN3LnjQlocdz7As8I+84zhhvSILqWL2\n/QG9XXwzAgMBAAECggEAT/oVJGT4PjuUmTNO4VrRZA90GhQJXqoVvv++SV2it1go\n/hcDLO+VasYjH8QNAoXkJiO1+79mBKpFOJPiVx/TA086svzkr5WJENi4C1zNY7vw\nZZhCdHp/wUGf7N5qW+NlvleA2hqhkAbAWwRmihyKGyI5eGxPZjiZR4M/64PqI4Cz\nth4y4pUCVv3EnAP4kVgQbRhs/ZipFthBEmMS50uPQViwUBQP0NWRxtQwWELrRfD2\ne7SJhIt6slQwGc89jjI/nr/W9j/A4yOb1VOzQjLfhlyztj2VHbOBmfOPIyv6JSd1\n215vvlmVwOzrpsBAiTs0veJtin6RK1rB4MtJa/TU8QKBgQDjPqD6m+fAMF1yazZ6\n6D0JeOq9ATp8X1z9BNW61cZxsh4RMMC0F6r+QgS4V+4MI/XZWN60BIsIu/E52Eol\nC60t3Sv8anbX/NDq9NXx8Xp1LpmOJHL2K8lVahuauWwUzYSTHBoSB6QmsSDDP+mF\ng4SaPlEoBCVKaNP75gnZrVBMcQKBgQC/L7GfhkxF32BnlZ0HNe1NXx53gMPvvy2w\nhBj1vIqOsrl571OOABcBaoJqWK7QFGW9q1EvjYPf8jUvWYrqSrvvCUYH7DiM2IjB\nFYF3Uu9QeRuN40o6UdDrHFieNWHxjg3xX6RDw2e4zEmK/aJV97E2naPpIFlu+OCs\nc9s4ai704wKBgQCrJSn8VJrwBfz7BYAchPgjQCwaeOhhbzkLXi7R7drtGibG757S\ng9jGcVY4uBCSmCq6rNHdZmaIB3QgCqOczvR4zFAqZMxo0wFNU2QmOaXux0/i29Sx\nTjzt1WJA31FlQXuNh+aimZqpgVGZe3MWmPyvZiudJbIoHlc5KgFVLdCCIQKBgHdB\nmNqZOxqaq9fxS3IkAVIx8x84AwCZkDZ7L9aZNRSuB2Q4FTaOd8s6VP9hMio5jv0w\n0AOJkqkuvF48zJo44+HHNxfaEaxJpYRLleaIpR7dbIKlNLgMMPV3SQ/m3KGAqtHV\nhvF+AkUTqQw6Cfj1+GTJEGVq+F5wgDUST7xw/7lhAoGBAKKkuBT9PA2vRCJZ9YDz\nNveVeDIoEAHfyyfzGO9FlHlSFiUTgDJ1KHjFvwG8uFuoVveyFoDgFt6ozKTdb69f\nYZ+UULmYwmjOMnTZ0aJoaebPJRzJRyDvgisuBWA0LxEME2GyjkrtORWxeOcJgHZY\nY/C7S48INzAwnhU9Xwfty0Eh\n-----END PRIVATE KEY-----\n",
  "client_email": "swiftloadservice@swiftload-youtube.iam.gserviceaccount.com",
  "client_id": "117361298476394739170",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/swiftloadservice%40swiftload-youtube.iam.gserviceaccount.com"
}
 """;
  static final _spreadsheetId = '1o71ygg8kFr7L8fvdcF3t_R1igS2he0-nA9ISWWpq5cM';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _videosSheet;

  static Future init() async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _videosSheet = await _getWorkSheet(spreadsheet, title: 'Videos');
      final firstRow = VideoFields.getFields();
      _videosSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<List<Video>> getAll() async{
    if (_videosSheet == null) return <Video>[];

    final videos = await _videosSheet!.values.map.allRows();
    return videos == null ? <Video>[] : videos.map(Video.fromJson).toList();
  }

  static Future<Video?> getBySlno(int slno) async{
    if (_videosSheet == null) return null;

    final json = await _videosSheet!.values.map.rowByKey(slno, fromColumn: 1);
    return json == null ? null : Video.fromJson(json);
  }

  static Future<Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet, {
        required String title,
      }) async{
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }
}