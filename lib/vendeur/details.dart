import 'package:firebase_storage/firebase_storage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile.dart';
import 'package:jibli/client/profile_client.dart';
import 'package:jibli/client/test.dart';
import 'package:jibli/main.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:photo_view/photo_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_animations/simple_animations.dart';
//import 'image.dart';


class details extends StatefulWidget {
  var document;
  String nom;
  details(this.document,this.nom);
  @override
  _details createState() => _details(document,nom);
}

class _details extends State<details> {
      static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['ecommerce', 'shopping'],
    childDirected: true,
  );
  InterstitialAd _interstitialAd ;
    InterstitialAd createinterstialAd() {
    return InterstitialAd(
   //   adUnitId: InterstitialAd.testAdUnitId,
        adUnitId: "ca-app-pub-3019770614934948/3162944376",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("interstitialAd : $event");
        });
  }
  var document;
  String nom;
  _details(this.document,this.nom);
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>image(document['image']))),
                child: Hero(
                  tag: document['image'],
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.8+30,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Image.network(
                      document['image']
                      ,fit: BoxFit.fill,),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height/26, left: MediaQuery.of(context).size.width/15,
                child: GestureDetector(
                  onTap: ()=>Navigator.of(context).pop(),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey, spreadRadius: 3, blurRadius: 55)
                        ]),
                    height:ScreenUtil().setHeight(100),
                    width:ScreenUtil().setWidth(100),
                    child:Icon(Icons.arrow_back,size: ScreenUtil().setSp(40),color: Colors.purple[300],),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2),
                child: Container(
                  // height: ScreenUtil().setHeight(700),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[800],
                            blurRadius: 55,
                            spreadRadius: 10)
                      ]),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                        ),
                        //height: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child:Text(
                                  "Détails",
                                  style:  GoogleFonts.oswald(textStyle: TextStyle(
                                      fontSize: ScreenUtil().setSp(50),
                                      color: Colors.black87
                                  ))
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/26,top: 11),
                              //   left: ScreenUtil().setWidth(40),top: ScreenUtil().setHeight(22),
                              child: Text(
                                  document['title'],
                                  style:  GoogleFonts.oswald(textStyle: TextStyle(
                                      fontSize: ScreenUtil().setSp(38),
                                      color: Colors.black87
                                  ))
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(left:MediaQuery.of(context).size.width/35,right: 18,top: 10),
                              child: Text(
                                  document["description"]
                                  ,
                                  style: GoogleFonts.pangolin(
                                      textStyle: TextStyle(
                                        fontSize: ScreenUtil().setSp(38),
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black38,
                                      )
                                  )
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height/2.6,),
                        child: Container(
                          height: ScreenUtil().setHeight(240),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 55,
                                    spreadRadius: 8
                                )
                              ],
                              gradient: LinearGradient(colors: [
                                Colors.pink[500],
                                Colors.pink[900]
                              ]),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                // left: ScreenUtil().setWidth(50),
                                child: Text(
                                  "  "+document['prix']+" Da",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil().setSp(48),
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 7,
                                child: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 85.0),
                                      child: Container(
                                        height: ScreenUtil().setHeight(80),
                                        width: ScreenUtil().setWidth(80),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.white, width: 3),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12))),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 3,),
                                            child: Text(
                                                "Suppremier",
                                                style: TextStyle(
                                                    fontSize: ScreenUtil().setSp(40),
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: ()async {
                                    await  createinterstialAd()..load()..show();        
                                                      FirebaseStorage.instance.ref()
                                                      .child(document['imagesupp'])
                                                      .delete();
                                                  Firestore.instance.collection(nom).document(
                                                      document.documentID).delete();
                                                  Firestore.instance.collection('users').document(
                                                      document['category'])
                                                      .collection(document['category']).document(
                                                      document.documentID).delete();
                                    
                                          Navigator.of(context).pop();            
                                    
                                    }),
                              ),Expanded(child: Container())
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class image extends StatefulWidget {
  String photo;
  image(this.photo);
  @override
  _imageState createState() => _imageState(photo);
}

class _imageState extends State<image> {
  _imageState(this.photo);
  String photo;
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
                photo,
              )),
        ));
  }
}

