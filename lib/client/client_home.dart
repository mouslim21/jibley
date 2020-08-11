//import 'dart:html';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import './carousel.dart';
import './components.dart';
import 'profile_client.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:carousel_slider/carousel_slider.dart';

class client_home extends StatefulWidget {
  @override
  _client_homeState createState() => _client_homeState();
}

class _client_homeState extends State<client_home> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['ecommerce', 'shopping'],
    childDirected: true,
  );
  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: "ca-app-pub-3019770614934948/3322726472",
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3019770614934948~7725005919");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  final TextEditingController _searchDoctor = new TextEditingController();
  String _searchText = "";

  //Monitor the instant change in the search text
  _client_homeState() {
    _searchDoctor.addListener(() {
      if (_searchDoctor.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _searchDoctor.text;
          print(_searchText);
        });
      }
      ;
    });
  }
  TextStyle categories = GoogleFonts.oswald(
      textStyle: TextStyle(fontSize: 20, color: Colors.black87));
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          body: ListView(
            //shrinkWrap: true,
            //physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(550),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: ScreenUtil().setHeight(500),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              spreadRadius: 2,
                              blurRadius: 25)
                        ],
                        gradient: LinearGradient(
                            colors: [Colors.pink[900], Colors.pink[400]]),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            height: ScreenUtil().setHeight(150),
                            child: Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height: ScreenUtil().setHeight(90),
                                  width: ScreenUtil().setWidth(660),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Center(
                                      child: TextField(
                                        controller: _searchDoctor,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0.5),
                                            icon: Icon(
                                              Icons.search,
                                              color: Colors.grey[800],
                                            ),
                                            border: InputBorder.none,
                                            hintText: "Rechercher ... ",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize:
                                                    ScreenUtil().setSp(30))),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                          Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 5,
                                        color: Colors.grey[200],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black26,
                                            spreadRadius: 2,
                                            blurRadius: 25)
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      color: Colors.grey[200]),
                                  height: ScreenUtil().setHeight(400),
                                  width: ScreenUtil().setWidth(680),
                                  child: StreamBuilder(
                                    stream: Firestore.instance
                                        .collection("carousel")
                                        .snapshots(),
                                    builder: (context, snapshot) =>snapshot.hasData==null?Center(
                                      child: CircularProgressIndicator(),
                                    ): Carousel(
                                      borderRadius: true,
                                      boxFit: BoxFit.cover,
                                      autoplay: true,
                                      autoplayDuration: Duration(seconds: 3),
                                      animationCurve: Curves.fastOutSlowIn,
                                      animationDuration:
                                          Duration(milliseconds: 1000),
                                      dotSize: 6.0,
                                      dotIncreasedColor: Colors.pink[900],
                                      dotBgColor: Colors.transparent,
                                      dotVerticalPadding: 10.0,
                                      showIndicator: true,
                                      indicatorBgPadding: 7.0,
                                      images: snapshot.data.documents
                                          .map((document) =>Image(fit: BoxFit.fill,image: NetworkImage(document['carousel'])) )
                                          .toList(),
                                    ),
                                  )))
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Container(
//            color: Colors.grey[200],
                child: StreamBuilder(
                    stream: Firestore.instance.collection("users2").snapshots(),
                    builder: (context, snapshoot) {
                      //shrinkWrap: true,
                      // physics: ScrollPhysics(),
                      if (snapshoot.data == null)
                        return Center(child: CircularProgressIndicator());
                      switch (snapshoot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: Color(0xff5097a4),
                          ));
                        default:
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                snapshoot.data.documents
                                            .map<Widget>((document) =>
                                                categorie_card(
                                                    context, document))
                                            .toList()
                                            .length ==
                                        0
                                    ? Center(
                                        child: Column(
                                        children: <Widget>[
                                          Container(
                                            height: ScreenUtil().setHeight(160),
                                          ),
                                          Center(
                                            child: Icon(Icons.error,
                                                size: ScreenUtil().setSp(58),
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "\nil y'a pas des produits pour le moment",
                                            style: TextStyle(
                                                fontSize:
                                                    ScreenUtil().setSp(38),
                                                color: Colors.grey),
                                          )
                                        ],
                                      ))
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, top: 0),
                                        child: Text("Les catégories",
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.oswald(
                                                textStyle: TextStyle(
                                                    fontSize:
                                                        ScreenUtil().setSp(36),
                                                    color: Colors.black87))),
                                      ),
                                Container(
                                  height: ScreenUtil().setHeight(170),
                                  child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: snapshoot.data.documents
                                          .map<Widget>((document) =>
                                              categorie_card(context, document))
                                          .toList()),
                                ),
                              ]);
                      }
                    }),
              ),

              StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document("Homme")
                    .collection("Homme")
                    .snapshots(),
                builder: (context, snapshoot) {
                  if (snapshoot.data == null)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  var l = snapshoot.data.documents
                      .map<Widget>((document) => Nex_x6p(context, document, 0))
                      .toList();
                  return Column(
                    children: <Widget>[
                      (_searchText == null || _searchText.toString() == "")
                          ? (l.length == 0
                              ? Container()
                              : GestureDetector(
                                  child: title_bar(context, "Homme"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profil_client(nom: "Homme")));
                                  },
                                ))
                          : (makelist3(snapshoot, 0).length == 0
                              ? Container()
                              : GestureDetector(
                                  child: title_bar(context, "Homme"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profil_client(nom: "Homme")));
                                  },
                                )),
                      Container(
                        // margin: EdgeInsets.all(4),
                        height: (_searchText == null ||
                                _searchText.toString() == "")
                            ? (l.length < 4
                                ? (l.length == 0
                                    ? 0
                                    : ScreenUtil().setHeight(320))
                                : ScreenUtil().setHeight(630))
                            : (makelist3(snapshoot, 0).length < 4
                                ? (makelist3(snapshoot, 0).length == 0
                                    ? 0
                                    : ScreenUtil().setHeight(320))
                                : ScreenUtil().setHeight(630)),
                        color: Colors.transparent,
                        child: GridView.count(
                          crossAxisSpacing: 8,
                          childAspectRatio:
                              MediaQuery.of(context).size.width > 800
                                  ? 1.2
                                  : 0.8,
                          mainAxisSpacing: 2,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          crossAxisCount: 3,
                          children: (_searchText == null ||
                                  _searchText.toString() == "")
                              ? List.generate(
                                  l.length > 6 ? 6 : l.length,
                                  (index) => snapshoot.data.documents
                                      .map<Widget>((document) =>
                                          Nex_x6p(context, document, index))
                                      .toList()
                                      .elementAt(index))
                              : List.generate(
                                  makelist3(snapshoot, 0).length > 6
                                      ? 6
                                      : makelist3(snapshoot, 0).length,
                                  (index) => makelist3(snapshoot, index)
                                      .elementAt(index)),
                        ),
                      )
                    ],
                  );
                },
              ),
              Carroussel(_searchText),

              //title_bar(context, "enfants"),
              /*StreamBuilder(
                    stream: Firestore.instance.collection("users").document("enfants")
                    .collection("enfants").snapshots(),
                    builder: (context,snapshoot){
                    //  var l =;
                      return Container(
          height:snapshoot.data.documents.map<Widget>((document)=> Nex_x6p(context,document)).toList().length>3?300:150,
                       color: Colors.transparent,
          child: GridView.count(
            crossAxisSpacing: 5,
            childAspectRatio: 0.8,
            mainAxisSpacing: 2,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            crossAxisCount: 3,

            children: List.generate(snapshoot.data.documents.map<Widget>((document)=> Nex_x6p(context,document)).toList().length>6?6:
            snapshoot.data.documents.map<Widget>((document)=> Nex_x6p(context,document)).toList().length, (index) =>
                snapshoot.data.documents.map<Widget>((document)=> Nex_x6p(context,document)).toList().elementAt(index)),
            ),
                      );
                    },
                  ),*/

              Produitlist(context, "Kids", _searchText),

              StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document("Informatiques")
                    .collection("Informatiques")
                    .snapshots(),
                builder: (context, snapshoot) {
                  if (snapshoot.data == null)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  var l = snapshoot.data.documents
                      .map<Widget>((document) => Nex_x6p(context, document, 0))
                      .toList();
                  return Column(
                    children: <Widget>[
                      (_searchText == null || _searchText.toString() == "")
                          ? (l.length == 0
                              ? Container()
                              : GestureDetector(
                                  child: title_bar(context, "Informatiques"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profil_client(nom: "Informatiques")));
                                  },
                                ))
                          : (makelist3(snapshoot, 0).length == 0
                              ? Container()
                              : GestureDetector(
                                  child: title_bar(context, "Informatiques"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profil_client(nom: "Informatiques")));
                                  },
                                )),
                      Container(
                        // margin: EdgeInsets.all(4),
                        height: (_searchText == null ||
                                _searchText.toString() == "")
                            ? (l.length < 4
                                ? (l.length == 0
                                    ? 0
                                    : ScreenUtil().setHeight(320))
                                : ScreenUtil().setHeight(630))
                            : (makelist3(snapshoot, 0).length < 4
                                ? (makelist3(snapshoot, 0).length == 0
                                    ? 0
                                    : ScreenUtil().setHeight(320))
                                : ScreenUtil().setHeight(630)),
                        color: Colors.transparent,
                        child: GridView.count(
                          crossAxisSpacing: 8,
                          childAspectRatio:
                              MediaQuery.of(context).size.width > 800
                                  ? 1.2
                                  : 0.8,
                          mainAxisSpacing: 2,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          crossAxisCount: 3,
                          children: (_searchText == null ||
                                  _searchText.toString() == "")
                              ? List.generate(
                                  l.length > 6 ? 6 : l.length,
                                  (index) => snapshoot.data.documents
                                      .map<Widget>((document) =>
                                          Nex_x6p(context, document, index))
                                      .toList()
                                      .elementAt(index))
                              : List.generate(
                                  makelist3(snapshoot, 0).length > 6
                                      ? 6
                                      : makelist3(snapshoot, 0).length,
                                  (index) => makelist3(snapshoot, index)
                                      .elementAt(index)),
                        ),
                      )
                    ],
                  );
                },
              ),

              vendeurs_page(context, _searchText),
              Produitlist(context, "Smartphone", _searchText),
             /* StreamBuilder(
                stream: Firestore.instance
                    .collection("users")
                    .document("Homme")
                    .collection("Homme")
                    .snapshots(),
                builder: (context, snapshoot) {
                  if (snapshoot.data == null)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  var l = snapshoot.data.documents
                      .map<Widget>((document) => Nex_x6p(context, document, 0))
                      .toList();
                  return Column(
                    children: <Widget>[
                      (_searchText == null || _searchText.toString() == "")
                          ? (l.length == 0
                              ? Container()
                              : GestureDetector(
                                  child: title_bar(context, "Homme"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profil_client(nom: "Homme")));
                                  },
                                ))
                          : (makelist3(snapshoot, 0).length == 0
                              ? Container()
                              : GestureDetector(
                                  child: title_bar(context, "Homme"),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Profil_client(nom: "Homme")));
                                  },
                                )),
                      Container(
                        // margin: EdgeInsets.all(4),
                        height: (_searchText == null ||
                                _searchText.toString() == "")
                            ? (l.length < 4
                                ? (l.length == 0
                                    ? 0
                                    : ScreenUtil().setHeight(320))
                                : ScreenUtil().setHeight(630))
                            : (makelist3(snapshoot, 0).length < 4
                                ? (makelist3(snapshoot, 0).length == 0
                                    ? 0
                                    : ScreenUtil().setHeight(320))
                                : ScreenUtil().setHeight(630)),
                        color: Colors.transparent,
                        child: GridView.count(
                          crossAxisSpacing: 8,
                          childAspectRatio:
                              MediaQuery.of(context).size.width > 800
                                  ? 1.2
                                  : 0.8,
                          mainAxisSpacing: 2,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          crossAxisCount: 3,
                          children: (_searchText == null ||
                                  _searchText.toString() == "")
                              ? List.generate(
                                  l.length > 6 ? 6 : l.length,
                                  (index) => snapshoot.data.documents
                                      .map<Widget>((document) =>
                                          Nex_x6p(context, document, index))
                                      .toList()
                                      .elementAt(index))
                              : List.generate(
                                  makelist3(snapshoot, 0).length > 6
                                      ? 6
                                      : makelist3(snapshoot, 0).length,
                                  (index) => makelist3(snapshoot, index)
                                      .elementAt(index)),
                        ),
                      )
                    ],
                  );
                },
              ),*/
              //Produitlist(context, "Informatiques", context),
            ],
          )),
    );
  }

  List<Widget> makelist2(AsyncSnapshot snapshot, int index) {
    return snapshot.data.documents.map<Widget>((document) {
      if (document['title']
              .toString()
              .toLowerCase()
              .contains(_searchText.toString()) ||
          document['title']
              .toUpperCase()
              .toString()
              .contains(_searchText.toString()) ||
          document['title'].toString().contains(_searchText.toString())) {
        return Nex_x6p(context, document, index);
      }
    }).toList();
  }

  List<Widget> makelist3(AsyncSnapshot snapshot, int index) {
    List<Widget> list = [];
    for (int i = 0; i < makelist2(snapshot, index).length; i++) {
      if (makelist2(snapshot, index).elementAt(i) != null) {
        list.add(makelist2(snapshot, index).elementAt(i));
      }
    }
    return list.toList();
  }
}
