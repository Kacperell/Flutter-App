import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadingFiles extends StatefulWidget {
  String _title;
  DownloadingFiles(this._title);

  @override
  _DownloadingFilesState createState() => _DownloadingFilesState();
}

class _DownloadingFilesState extends State<DownloadingFiles> {
  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    return DownloadingFilesScreen(
      title: widget._title,
      platform: platform,
    );
  }
}

class DownloadingFilesScreen extends StatefulWidget {
  final TargetPlatform platform;
  final String title;

  DownloadingFilesScreen({Key key, this.title, this.platform})
      : super(key: key);

  @override
  _DownloadingFilesScreenState createState() => _DownloadingFilesScreenState();
}

class _DownloadingFilesScreenState extends State<DownloadingFilesScreen> {
  bool _isLoading;
  bool _permissionReady;
  String _localPath;
  ReceivePort _port = ReceivePort();

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Widget _buildNoPermissionWarning() => Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Please grant accessing storage permission to continue -_-',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              FlatButton(
                  onPressed: () {
                    _checkPermission().then((hasGranted) {
                      setState(() {
                        _permissionReady = hasGranted;
                      });
                    });
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ))
            ],
          ),
        ),
      );

  Future<Null> _prepare() async {
    _permissionReady = await _checkPermission();
    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Download';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> _findLocalPath() async {
    final directory = widget.platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    _permissionReady = false;
    _prepare();

    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      if (status == DownloadTaskStatus.complete) {
        if (type == 1) {
          print('Zdjęcie pobrane w czasie:${stopwatch.elapsed}');
          setState(() {
            photoStatus = 'Zdjęcie pobrane w czasie:${stopwatch.elapsed}';
          });
        } else if (type == 2) {
          setState(() {
            videoStatus = 'Film został pobrany czasie:${stopwatch.elapsed}';
          });
        }
      }
      int progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  int type = 0;

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  var stopwatch;

  void downloadPhoto() async {
    type = 1;
    setState(() {
      photoStatus = 'Pobieranie';
    });
    stopwatch = Stopwatch()..start();
    final taskId = await FlutterDownloader.enqueue(
      url:
          'https://upload.wikimedia.org/wikipedia/commons/7/78/Canyonlands_National_Park%E2%80%A6Needles_area_%286294480744%29.jpg',
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  void downloadMovie() async {
    type = 2;
    setState(() {
      videoStatus = 'Pobieranie';
    });
    stopwatch = Stopwatch()..start();
    final taskId = await FlutterDownloader.enqueue(
      url:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
      savedDir: _localPath,
      showNotification: true,
      openFileFromNotification: true,
    );
  }

  String photoStatus = '';
  String videoStatus = '';

  Widget _buildDownloadList() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('${photoStatus}'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 270,
                child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: new Text('Pobierz zdjęcie (2,36 MB)'),
                    onPressed: downloadPhoto),
              ),
            ),
            Text('${videoStatus}'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 270,
                child: FlatButton(
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Text('Pobierz Film (158 MB)'),
                    onPressed: downloadMovie),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Builder(
          builder: (context) => _isLoading
              ? new Center(
                  child: new CircularProgressIndicator(),
                )
              : _permissionReady
                  ? _buildDownloadList()
                  : _buildNoPermissionWarning()),
    );
  }
}
