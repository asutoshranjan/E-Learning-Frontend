import 'package:e_learning_ytuploads/videodata.dart';
import 'package:gsheets/gsheets.dart';

class VideosSheetsApi{
  static const _credentials = r"""
{
  
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