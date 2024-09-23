// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tradmed/Features/Medapp/Presentation/pages/NavBar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Educationpage extends StatefulWidget {
  const Educationpage({super.key});

  @override
  State<Educationpage> createState() => _EducationpageState();
}

class _EducationpageState extends State<Educationpage> {
  // 1st reffer how to do it using single youtube video on notepad
  // List of video URLs
  final List<String> videoUrls = [
    'https://youtu.be/_zlKpm6wGaQ?si=4sOku-R0pH3hRZRl',
    'https://youtu.be/1Uq_7Gm6zQk?si=8zf4QqYML32VpK4u',
    'https://youtu.be/F06wSDOyIqM?si=0VQ2NsCB8lUYJW5X',
    'https://youtu.be/wyOIDoh14pk?si=9fuGZCHMYjrr5b0a'
    'https://youtu.be/xKEylDUTQXM?si=8nz9mcrmo_yzAlTV',
    'https://youtu.be/OkyIlN1-LKk?si=zGPgmTR_GCl656LT'
    'https://youtu.be/tMkWdGX1Res?si=c1P0tqgRWOHJylEA',
    'https://youtu.be/yyMBKfEXUUI?si=JswOTw11a1PqTMVu',
    'https://youtu.be/V4Fj92AADcI?si=0xyKJ-oow7YQH1xy',
  ];

  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    // Initialize controllers for each video
    _controllers = videoUrls
        .map((url) => YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(url)!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                enableCaption: false,
              ),
            ))
        .toList();
  }

  @override
  void dispose() {
    // Disposes unused controllers
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Nav(),
      appBar: AppBar(
        title: Text('Education'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                child: Text(
                  'Special For You',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),

              // Use ListView for displayi
              Expanded(
                child: ListView.builder(
                  itemCount: _controllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: YoutubePlayer(
                          controller: _controllers[index],
                          showVideoProgressIndicator: true,
                          bottomActions: [
                            ProgressBar(
                              isExpanded: true,
                              colors: ProgressBarColors(
                                playedColor: Colors.red,
                                handleColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
