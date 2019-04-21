import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(Home());
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Example',
      home: VideoExample(),
    );
  }
}

class VideoExample extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<VideoExample> {
  VideoPlayerController playerController;
  VoidCallback listener;

  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
  }

  void createVideo() {
    if (playerController == null) {
      playerController = VideoPlayerController.network(
          "https://r2---sn-u3h5gvnoxu-qhxe.googlevideo.com/videoplayback?id=41855ccb694fa122&itag=18&source=blogger&mm=31&mn=sn-u3h5gvnoxu-qhxe&ms=au&mv=m&pl=25&ei=RqW8XMCpAdGGxwPJ5424DA&susc=bl&mime=video/mp4&dur=2714.969&lmt=1552917369735818&mt=1555866832&ip=194.48.152.52&ipbits=0&expire=1555895750&sparams=ip,ipbits,expire,id,itag,source,mm,mn,ms,mv,pl,ei,susc,mime,dur,lmt&signature=AF611E31E5FCB5A60E52AA766D276B9645FA9F04683BA30C1BAE285B85D90437.C8654BC19544DF740371D8E986F9727F77B4E5C81470A2592E7B3BCC1590BA47&key=us0")
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Example'),
      ),
      body: Center(
          child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                child: (playerController != null
                    ? VideoPlayer(
                        playerController,
                      )
                    : Container()),
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createVideo();
          playerController.play();
        },
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
