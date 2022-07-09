import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
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
  bool flag = false;
  final videofileController = TextEditingController();
  final thumbnailfileController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final keywordsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    videofileController.addListener(() => setState(() {}));
    thumbnailfileController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swift Load"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 13.5),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.54,
                  color: Colors.redAccent),
              Column(
                children: [
                  SizedBox(height: 70),

                  // Video Location Input
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        videofilelocation = value;
                        file = videofilelocation.replaceAll(r'\', r'\\');
                      }),
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        thumbnailfilelocation = value;
                        thumbnailfilelocation =
                            thumbnailfilelocation.replaceAll(r'\', r'\\');
                      }),
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        title = value;
                        title = title.replaceAll(r'\', '\\');
                      }),
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onChanged: (value) => setState(() {
                        description = value;
                        description = description.replaceAll(r'\', '\\');
                      }),
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
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextField(
                      onSubmitted: (value) => setState(() {
                        url = value;
                      }),
                      onChanged: (value) => setState(() {
                        keywords = value;
                        keywords = keywords.replaceAll(r'\', '\\');
                      }),
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

                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
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

                  SizedBox(height: 30),

                  if (outvideoid != "") Link(
                    target: LinkTarget.blank,
                    uri: Uri.parse("https://www.youtube.com/watch?v=$outvideoid"),
                    builder:(context, followLink) => RaisedButton(
                      onPressed: followLink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.green[200],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
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
                        valueColor: AlwaysStoppedAnimation(Color(
                            0xffFDB99B)), // Defaults to the current Theme's accentColor.
                        backgroundColor: Colors
                            .white, // Defaults to the current Theme's backgroundColor.
                        borderColor: Color(0xffc6a9ff),
                        borderWidth: 3.0,
                        direction: Axis
                            .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                        center: Text(" "),
                      ),
                    ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
