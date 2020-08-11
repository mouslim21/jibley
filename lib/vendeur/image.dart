import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class image extends StatefulWidget {
  String photo;
  var photo2;
  image(this.photo2,this.photo);
  @override
  _imageState createState() => _imageState(photo2,photo);
}

class _imageState extends State<image> {
  _imageState(this.photo2,this.photo);
  String photo;
  var photo2;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: photo,
      child: Container(
          height: 400,
          width: double.infinity,
          color: Colors.transparent,
          child: PhotoView(
            imageProvider: NetworkImage(
              photo2,
          )),
    ));
  }
}



