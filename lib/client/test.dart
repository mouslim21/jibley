import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

getlocation ()async{
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  print(position);
  print(position.latitude);
  var lat = position.latitude;
  var long = position.longitude ;
}


class sel3a_buy extends StatefulWidget {
  @override
  _sel3a_buyState createState() => _sel3a_buyState();
}

class _sel3a_buyState extends State<sel3a_buy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

      ),
    );
  }
}

