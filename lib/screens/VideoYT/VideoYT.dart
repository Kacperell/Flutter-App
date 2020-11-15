import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoYT extends StatefulWidget {
  String _title;
  VideoYT(this._title);

  @override
  _VideoYTState createState() => _VideoYTState();
}

class _VideoYTState extends State<VideoYT> {
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'fwkJtgVswgM',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              ),
            ]),
      ),
    );
  }
}
