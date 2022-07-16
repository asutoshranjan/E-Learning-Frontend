import 'dart:convert';
import 'dart:io';

import 'package:e_learning_ytuploads/api/google_sheets/videos_sheets_api.dart';
import 'package:e_learning_ytuploads/videodata.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await VideosSheetsApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Learning Uploads',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          suffixIconColor: Colors.redAccent,
          prefixIconColor: Color(0xff57ACDC),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff276bb0)),
          ),
          hintStyle: TextStyle(color: Colors.blueAccent[100], letterSpacing: 1, fontSize: 16),
          labelStyle: TextStyle(color: Color(0xff57ACDC), letterSpacing: 1, fontSize: 16),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AsciiApi(),
    );
  }
}

class AsciiApi extends StatefulWidget {
  const AsciiApi({Key? key}) : super(key: key);

  @override
  _AsciiApiState createState() => _AsciiApiState();
}

class _AsciiApiState extends State<AsciiApi> {
  List<Video> videos = [];
  List<Map<String, dynamic>> mapvideos = [];
  String videofilelocation = "";
  String thumbnailfilelocation = "";
  String title = "";
  String description = "";
  String keywords = "";
  String file = "";
  String url = "";
  String category = "22";
  String privacyStatus = "private";
  String outvideofile = "";
  String outvideoid = "";
  String outtitle = "";
  String outdescription = "";
  String outcategory = "";
  String outkeywords = "";
  String outprivacyStatus = "";
  String outthumbnail = "";

  String muloutvideofile = "";
  String muloutvideoid = "";
  String mulouttitle = "";
  String muloutdescription = "";
  String muloutcategory = "";
  String muloutkeywords = "";
  String muloutprivacyStatus = "";
  String muloutthumbnail = "";
  double mulvalue = 0.0;
  int mulnumber = 0;


  List<int> sheet_slnos = [];
  List<String> sheet_video_files = [];
  List<String> sheet_thumbnail_files = [];
  List<String> sheet_titles = [];
  List<String> sheet_descriptions = [];
  List<String> sheet_category = [];
  List<String> sheet_keywords = [];
  List<String> sheet_privacystatus = [];
  int sheet_length = 0;
  bool flag = false;
  bool mulflag = false;
  final videofileController = TextEditingController();
  final thumbnailfileController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final keywordsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getVideos();
    videofileController.addListener(() => setState(() {}));
    thumbnailfileController.addListener(() => setState(() {}));
  }

  Future getVideos() async {
    final videos = await VideosSheetsApi.getAll();

    setState(() {
      this.videos = videos;
      sheet_length = videos.length;
    });

    setState(() {
      if (videos.isNotEmpty) {
        for (int i = 0; i < sheet_length; i++) {
          mapvideos.add(videos[i].toJson());
        }
      }
      for (int i = 0; i < mapvideos.length; i++) {
        var snap = mapvideos[i];
        sheet_slnos.add(snap["slno"]);
        sheet_video_files.add(snap["video_file"].replaceAll(r'\', r'\\'));
        sheet_thumbnail_files
            .add(snap["thumbnail_file"].replaceAll(r'\', r'\\'));
        sheet_titles.add(snap["title"]);
        sheet_descriptions.add(snap["description"]);
        sheet_category.add(snap["category"]);
        sheet_keywords.add(snap["keywords"]);
        sheet_privacystatus.add(snap["privacystatus"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            SizedBox(width: 20),
            Container(
              height: 60,
              width: 60,
              child: Image.network(
                "https://www.pngmart.com/files/10/Internet-Speedometer-Transparent-Background.png",
              ),
            ),
            SizedBox(width: 15),
            Text("Swift Load", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 3),),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.5),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      height: 80,
                  ),
                  
                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Row(
                      children: [
                        Expanded(flex: 3, child: Image.network("https://www.rawshorts.com/blog/wp-content/uploads/2019/10/youtube-video-marketing-.gif")),
                        SizedBox(width: 25,),
                        Expanded(flex: 4, child: Text("Upload Your YouTube Videos With Convenience and Speed Directly from Sheets.", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.white, height: 1.6),)),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
                  ),

                  SizedBox(height: 170,),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1. Click on OPEN GOOGLE SHEET", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Color(0xFFFC77EC),),),
                        SizedBox(height: 40),
                        Text("2. Click UPDATE SHEET to sync all your data", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Color(0xffd790fd), ),),
                        SizedBox(height: 40),
                        Text("3. Click UPLOAD to upload all the videos using sheet data", style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Colors.green[300],),),
                      ],
                    ),
                  ),

                  SizedBox(height: 140,),

                ],
              ),
              Column(
                children: [
                  SizedBox(height: 70),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: Row(
                      children: [
                        const SizedBox(width: 20,),
                        const Text(" Upload From Sheets ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 7,),
                        Expanded(
                          child: Container(
                            height: 6,
                            color: Color(0xFFFF64F2),
                          ),
                        ),
                        const SizedBox(width: 20,),
                      ],
                    ),
                  ),

                  SizedBox(height: 87),

                  //Open Sheet
                  Link(
                    target: LinkTarget.blank,
                    uri: Uri.parse(
                        "https://docs.google.com/spreadsheets/d/1o71ygg8kFr7L8fvdcF3t_R1igS2he0-nA9ISWWpq5cM/edit?usp=sharing"),
                    builder: (context, followLink) => RaisedButton(
                      onPressed: followLink,
                      shape: StadiumBorder(),
                      color: Colors.green[300],
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: MediaQuery.of(context).size.width * 0.06),
                        child: Row(
                          children: const [
                            Icon(Icons.description_outlined, size: 30, color: Colors.white,),
                            SizedBox(width: 12,),
                            Text(
                              " OPEN GOOGLE SHEET ",
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFF6FE),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 75),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: Row(
                      children: [
                        const SizedBox(width: 20,),
                        const Text(" To Be Uploaded ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 7,),
                        Expanded(
                          child: Container(
                            height: 4,
                            color: Color(0xFF8664FF),
                          ),
                        ),
                        const SizedBox(width: 20,),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  //Get Data :
                  Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                      children: [
                        Card(
                          shadowColor: Colors.white,
                          elevation: 20,
                          color: sheet_titles.isNotEmpty
                              ? Color(0xffd582fc)
                              : Color(0xffdfbdfd),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Index",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Center(
                                    child: Text(
                                      "File",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 1.2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Center(
                                    child: Text(
                                      "Title",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      "Status",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        letterSpacing: 1.4,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (sheet_slnos.isNotEmpty)
                          for (int i = 0; i < sheet_slnos.length; i++)
                            if (sheet_video_files[i] != "")
                              Card(
                                shadowColor: Colors.white,
                                color: Color(0xff4bd4af),
                                elevation: 20,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14, horizontal: 12),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: Text(
                                                  sheet_slnos[i].toString(), style: TextStyle(color: Colors.white, fontSize: 16.5, letterSpacing: 1, fontWeight: FontWeight.bold),),),),
                                      Expanded(
                                          flex: 4,
                                          child: Center(
                                              child:
                                                  Text(sheet_video_files[i], maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 16.3, letterSpacing: 1,),),),),
                                      Expanded(
                                          flex: 7,
                                          child: Center(
                                              child: Text(sheet_titles[i], style: TextStyle(color: Colors.white, fontSize: 16.5, letterSpacing: 1, fontWeight: FontWeight.bold),),),),
                                      Expanded(
                                          flex: 2,
                                          child: Center(
                                              child: Text(
                                                  sheet_privacystatus[i].replaceFirst("p", "P"), style: TextStyle(color: Colors.white, fontSize: 16.5, letterSpacing: 1, fontWeight: FontWeight.bold),),),),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  //Update Sheet Data
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton.icon(
                          color: Color(0xFFFF64F2),
                          onPressed: () {
                            setState(() {
                              mapvideos = [];
                              sheet_slnos = [];
                              sheet_video_files = [];
                              sheet_thumbnail_files = [];
                              sheet_titles = [];
                              sheet_descriptions = [];
                              sheet_category = [];
                              sheet_keywords = [];
                              sheet_privacystatus = [];
                              getVideos();
                            });
                          },
                          shape: StadiumBorder(),
                          elevation: 0,
                          icon: const Icon(Icons.sync_outlined, color: Colors.white),
                          label: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                            child: Text(
                              " UPDATE  SHEET ",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 25),
                      ],
                    ),
                  ),

                  SizedBox(height: 45),

                  //Upload from sheet data Button
                  RaisedButton(
                    onPressed: () async {
                      if(mulnumber<sheet_length) {
                        setState(() {
                          mulvalue = 0.45;
                          mulflag = true;
                          mulouttitle = "";
                          muloutvideoid = "";
                        });
                        if (sheet_video_files.isNotEmpty) {
                          String posturl = "http://127.0.0.1:5000/api";
                          final responce = await http.post(Uri.parse(posturl),
                              body: jsonEncode({
                                "video": sheet_video_files[mulnumber],
                                "title": sheet_titles[mulnumber],
                                "description": sheet_descriptions[mulnumber],
                                "category": sheet_category[mulnumber],
                                "keywords": sheet_keywords[mulnumber],
                                "privacyStatus": sheet_privacystatus[mulnumber],
                                "thumbnail": sheet_thumbnail_files[mulnumber],
                              }));
                        }

                        Future.delayed(Duration(seconds: 5), () async{
                          setState(() {
                            mulvalue = 0.85;
                          });
                          String geturl = "http://127.0.0.1:5000/api";
                          final response = await http.get(Uri.parse(geturl));
                          final decoded =
                          jsonDecode(response.body) as Map<String, dynamic>;
                          setState(() {
                            muloutvideofile = decoded["videofile"];
                            muloutthumbnail = decoded["thumbnail"];
                            mulouttitle = decoded["title"];
                            muloutvideoid = decoded["videoid"];
                            mulnumber++;
                            mulflag = false;
                          });
                        });

                      }
                    },
                    elevation: 0,
                    shape: StadiumBorder(),
                    color: (!mulflag)?Colors.green[300]:Colors.green[200],
                    child:  Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 17),
                      child: Text(
                        " UPLOAD  $mulnumber/$sheet_length ",
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFF6FE),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),

                  //Sheet Upload Indicator
                  if (mulflag && muloutvideoid == "")
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 40,
                      child: LiquidLinearProgressIndicator(
                        value: mulvalue, // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(Color(0xffff58b3)), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors.black, // Defaults to the current Theme's backgroundColor.
                        borderColor: Color(0xffca6bff),
                        borderWidth: 2.0,
                        borderRadius: 12.0,
                        direction: Axis.horizontal, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                        center: Text(" "),
                      ),
                    ),

                  if (mulouttitle != "")
                    Link(
                      target: LinkTarget.blank,
                      uri: Uri.parse(
                          "https://www.youtube.com/watch?v=$muloutvideoid"),
                      builder: (context, followLink) => RaisedButton(
                        elevation: 20,
                        hoverColor: Color(0xff53cbbe),
                        onPressed: followLink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.green[200],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 18),
                          child: Column(
                            children: [
                              Icon(
                                Icons.verified_outlined,
                                color: Colors.green[800],
                                size: 30,
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Upload Successful",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800]),
                              ),
                              SizedBox(height: 5),
                              Text(
                                mulouttitle,
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800]),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "https://www.youtube.com/watch?v=$muloutvideoid",
                                style: TextStyle(
                                  fontSize: 13.4,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 125),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: Row(
                      children: [
                        const SizedBox(width: 5,),
                        const Text(" Upload Using Fields ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 6,
                            color: Color(0xFFFF64F2),
                          ),
                        ),
                        const SizedBox(width: 5,),
                      ],
                    ),
                  ),

                  SizedBox(height: 30),

                  // Video Location Input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        videofilelocation = value;
                        file = videofilelocation.replaceAll(r'\', r'\\');
                      }),
                      style: TextStyle(color: Color(0xff57acdc), fontSize: 16.7, letterSpacing: 1),
                      controller: videofileController,
                      decoration: InputDecoration(
                        hintText: r'C:\Users\asuto\Desktop\DemoVideo.mp4',
                        labelText: 'Video Location',
                        prefixIcon: Icon(Icons.ondemand_video_outlined),
                        suffixIcon: videofileController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            videofileController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Thumbnail Location Input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        thumbnailfilelocation = value;
                        thumbnailfilelocation =
                            thumbnailfilelocation.replaceAll(r'\', r'\\');
                      }),
                      style: TextStyle(color: Color(0xff57acdc), fontSize: 16.7, letterSpacing: 1),
                      controller: thumbnailfileController,
                      decoration: InputDecoration(
                        hintText: r'C:\Users\asuto\Desktop\Thumbnail.png',
                        labelText: 'Thumbnail Location',
                        prefixIcon: Icon(Icons.photo_outlined),
                        suffixIcon: thumbnailfileController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            thumbnailfileController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),

                  SizedBox(height: 20),

                  // title Input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        title = value;
                        title = title.replaceAll(r'\', '\\');
                      }),
                      style: TextStyle(color: Color(0xff57acdc), fontSize: 16.7, letterSpacing: 1),
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: r'Enter video title here...',
                        labelText: 'Title',
                        prefixIcon: Icon(Icons.text_fields),
                        suffixIcon: titleController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            titleController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Description Input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        description = value;
                        description = description.replaceAll(r'\', '\\');
                      }),
                      style: TextStyle(color: Color(0xff57acdc), fontSize: 16.7, letterSpacing: 1),
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: r'Type the video description here...',
                        labelText: 'Description',
                        prefixIcon: Icon(Icons.text_fields),
                        suffixIcon: descriptionController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            descriptionController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),

                  SizedBox(height: 20),

                  // Keywords Input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: TextField(
                      onSubmitted: (value) => setState(() {
                        url = value;
                      }),
                      onChanged: (value) => setState(() {
                        keywords = value;
                        keywords = keywords.replaceAll(r'\', '\\');
                      }),
                      style: TextStyle(color: Color(0xff57acdc), fontSize: 16.7, letterSpacing: 1),
                      controller: keywordsController,
                      decoration: InputDecoration(
                        hintText: r'Youtube, Like, Comment, Script...',
                        labelText: 'Keywords',
                        prefixIcon: Icon(Icons.key_outlined),
                        suffixIcon: keywordsController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            keywordsController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ),

                  SizedBox(height: 20),

                  // All Inputs Done
                  // Save all data
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                          color: Color(0xFFFF64F2),
                          onPressed: () async {
                            String posturl = "http://127.0.0.1:5000/api";
                            final responce = await http.post(Uri.parse(posturl),
                                body: jsonEncode({
                                  "video": videofilelocation,
                                  "title": title,
                                  "description": description,
                                  "category": category,
                                  "keywords": keywords,
                                  "privacyStatus": privacyStatus,
                                  "thumbnail": thumbnailfilelocation
                                }));
                          },
                          shape: StadiumBorder(),
                          child: const Text(
                            " SAVE ",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 50),

                  //Upload From The Data
                  RaisedButton(
                    onPressed: () async {
                      setState(() {
                        flag = true;
                      });
                      String geturl = "http://127.0.0.1:5000/api";
                      final response = await http.get(Uri.parse(geturl));
                      final decoded =
                      jsonDecode(response.body) as Map<String, dynamic>;
                      setState(() {
                        outvideofile = decoded["videofile"];
                        outthumbnail = decoded["thumbnail"];
                        outtitle = decoded["title"];
                        outvideoid = decoded["videoid"];
                      });
                    },
                    shape: StadiumBorder(),
                    color: Colors.green[300],
                    child: const Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                      child: Text(
                        " UPLOAD ",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFFF6FE),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 50),

                  if (outvideoid != "")
                    Link(
                      target: LinkTarget.blank,
                      uri: Uri.parse(
                          "https://www.youtube.com/watch?v=$outvideoid"),
                      builder: (context, followLink) => RaisedButton(
                        onPressed: followLink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.green[200],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 18),
                          child: Column(
                            children: [
                              Icon(
                                Icons.verified_outlined,
                                color: Colors.green[800],
                                size: 30,
                              ),
                              SizedBox(height: 3),
                              Text(
                                "Upload Successful",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green[800]),
                              ),
                              SizedBox(height: 5),
                              Text(
                                outtitle,
                                style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                "https://www.youtube.com/watch?v=$outvideoid",
                                style: TextStyle(
                                  fontSize: 13.4,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[800],
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  if (flag && outvideoid == "")
                    Container(
                      height: 100,
                      width: 100,
                      child: LiquidCircularProgressIndicator(
                        value: 0.45, // Defaults to 0.5.
                        valueColor: AlwaysStoppedAnimation(Color(0xffFDB99B)), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors
                            .black, // Defaults to the current Theme's backgroundColor.
                        borderColor: Color(0xffc6a9ff),
                        borderWidth: 3.0,
                        direction: Axis
                            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        center: Text(" "),
                      ),
                    ),
                  SizedBox(height: 150),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
