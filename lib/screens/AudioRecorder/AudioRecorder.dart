import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:record_mp3/record_mp3.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioRecorder extends StatefulWidget {
  String _title;
  AudioRecorder(this._title);

  @override
  _AudioRecorderState createState() => _AudioRecorderState();
}

class _AudioRecorderState extends State<AudioRecorder> {
  String statusText = "";
  bool isComplete = false;

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${statusText}'),
              ),
              Container(
                width: 150.0,
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async {
                    startRecord();
                  },
                  child: Text('Nagraj'),
                ),
              ),
              Container(
                width: 150.0,
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () async {
                    stopRecord();
                  },
                  child: Text('Zatrzymaj'),
                ),
              ),
              Container(
                child: isComplete && recordFilePath != null
                    ? Container(
                        width: 150.0,
                        child: FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          onPressed: () async {
                            play();
                          },
                          child: Text('Odtwórz'),
                        ),
                      )
                    : Container(),
              ),
            ]),
      ),
    );
    // );
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Nagrywanie...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = " error--->$type";
        setState(() {});
      });
    } else {
      statusText = "Brak dostępu do mikrofnu";
    }
    setState(() {});
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {
        statusText = "Nagrywanie...";
        setState(() {});
      }
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {
        statusText = "Nagrywanie zatrzymane...";
        setState(() {});
      }
    }
  }

  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Nagrano";
      isComplete = true;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Nagrywanie...";
      setState(() {});
    }
  }

  String recordFilePath;

  void play() {
    if (recordFilePath != null && File(recordFilePath).existsSync()) {
      AudioPlayer audioPlayer = AudioPlayer();
      audioPlayer.play(recordFilePath, isLocal: true);
    }
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }
}
