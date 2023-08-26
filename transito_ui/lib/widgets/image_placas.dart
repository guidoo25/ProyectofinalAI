import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class MyImageListWidget extends StatefulWidget {
  @override
  _MyImageListWidgetState createState() => _MyImageListWidgetState();
}

class _MyImageListWidgetState extends State<MyImageListWidget> {
  int _imageCount = 0;

  @override
  void initState() {
    super.initState();
    _getImageCount();
  }

  Future<void> _getImageCount() async {
    try {
      final response = await Dio().get('http://localhost:5000/image/count');
      print (response.data);
      final count = int.tryParse(response.data);
      if (count != null) {
        setState(() {
          _imageCount = count;
        });
      } else {
        throw Exception('Failed to parse image count');
      }
    } catch (e) {
      throw Exception('Failed to load image count');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Placas detectadas'),
      ),
      body: ListView.builder(
        itemCount: _imageCount,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(
              'http://localhost:5000/images/objeto_${index + 1}.jpg',
              width: 50,
              height: 50,
            ),
            title: Text('Placas ${index + 1}'),
          );
        },
      ),
    );
  }
}