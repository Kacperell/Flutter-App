import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Camera extends StatefulWidget {
  String _title;
  Camera(this._title);

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  PickedFile _image;
  final picker = ImagePicker();

  Future getImage() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = PickedFile(image.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
              Container(
                child:
                    _image == null ? Text('') : Image.file(File(_image.path)),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: FlatButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: getImage,
                  child: Text('Zrób zdjęcie'),
                ),
              ),
            ]),
      ),
    );
  }
}
