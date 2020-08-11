import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class image_client extends StatefulWidget {
  @override
  _image_clientState createState() => _image_clientState();
}

class _image_clientState extends State<image_client> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "imagedetail",
      child: Container(
          height: 400,
          width: double.infinity,
          color: Colors.transparent,
          child: PhotoView(
            imageProvider: NetworkImage(
                "https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/95064254_2943622082397404_2884297412321476608_n.jpg?_nc_cat=102&_nc_sid=b9115d&_nc_ohc=i1aeBvqsbyQAX9c5kz3&_nc_ht=scontent-mrs2-2.xx&oh=b770d56d7e58707bc455b9cee1c75be6&oe=5EEB0B5F"),
          )),
    );
  }
}



