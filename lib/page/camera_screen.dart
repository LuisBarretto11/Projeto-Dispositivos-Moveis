import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  final Function(File) onFile;

  const CameraScreen({Key? key, required this.onFile}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
      ),
      body: CameraCamera(
        onFile: (file) {
          widget.onFile(file);
          Navigator.pop(context);
        },
      ),
    );
  }
}
