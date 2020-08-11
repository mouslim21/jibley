//import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jibli/client/profil_vendeur_client.dart';
import 'package:jibli/client/profile_client.dart';
import 'package:transparent_image/transparent_image.dart';
import 'detail_clients.dart';

//============================== Hadi nta3 l categories============================================================//
Widget categorie_card(BuildContext context, var doc) {
  Map list = {
    "Homme": "images/man.png",
    "Famme": "images/woman.png",
    "Informatiques": "images/informatique.png",
    "Smartphone": "images/smartphone.png",
    "Kids": "images/kids.png"
  };
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Profil_client(nom: doc["nom"]))),
    child: Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    offset: Offset(2, 3),
                    color: Colors.grey,
                    blurRadius: 2,
                    spreadRadius: 0.2)
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.grey, width: 3)),
          width: ScreenUtil().setHeight(124),
          height: ScreenUtil().setHeight(124),
          child: Center(
            //child: null,
            child: Image.asset(list[doc['nom']], color: Colors.grey[800]),
          ),
        ),
      ),
    ),
  );
}

//============================== Hadi nta3 l li fihm 6 m3a ba3dahm============================================================//
/*Widget produit_X6(BuildContext context,) {

  return Container(
    height: 288,
    color: Colors.transparent,
    child: Column(
    children: <Widget>[

        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 112,
                    width: 112,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://scontent-mrs2-1.xx.fbcdn.net/v/t1.0-9/97823873_606369159964774_6985373606653984768_n.jpg?_nc_cat=105&_nc_sid=8bfeb9&_nc_ohc=2xYcZbm5j6EAX9HWYUU&_nc_ht=scontent-mrs2-1.xx&oh=dce368ece268fa0bfcf60825ab8717b9&oe=5EEBD26D"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  texter(context, "t shirt")
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 112,
                    width: 112,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://scontent-mrs2-1.xx.fbcdn.net/v/t1.0-9/100528739_608026586465698_4180489881937510400_o.jpg?_nc_cat=109&_nc_sid=8bfeb9&_nc_ohc=C6gm3DxrXjMAX8ZUinp&_nc_ht=scontent-mrs2-1.xx&oh=d207146ba284a1aa1074698f0a144615&oe=5EEADE56"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  texter(context, "t shirt")
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 112,
                    width: 112,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://scontent-mrs2-2.xx.fbcdn.net/v/t1.0-9/95064254_2943622082397404_2884297412321476608_n.jpg?_nc_cat=102&_nc_sid=b9115d&_nc_ohc=i1aeBvqsbyQAX9c5kz3&_nc_ht=scontent-mrs2-2.xx&oh=b770d56d7e58707bc455b9cee1c75be6&oe=5EEB0B5F"),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  texter(context, "t shirt")
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
*/
Widget Nex_x6p(BuildContext context, var document, int index) {
  return GestureDetector(
    onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => details_client(document))),
    child: Column(
      children: <Widget>[
        Container(
          height: ScreenUtil().setHeight(225),
          width: ScreenUtil().setWidth(225),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage.assetNetwork(
              placeholder: index % 5 == 0 && index > 4
                  ? "images/2.png"
                  : (index % 4 == 0 && index > 3
                      ? "images/3.png"
                      : (index % 3 == 0 && index > 2
                          ? "images/4.png"
                          : (index % 2 == 0 && index > 1
                              ? "images/5.png"
                              : (index % 1 == 0
                                  ? "images/2.png"
                                  : "images/4.png")))),
              image: document['image'],
              fit: BoxFit.fill,
            ),
          ),
          decoration: BoxDecoration(
//  image: DecorationImage(
//  image:,
//  fit: BoxFit.fill),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        texter(context, document['title'])
      ],
    ),
  );
}

//============================== Hadi mat9ayamhach brk ============================================================//
Widget texter(BuildContext context, String title) {
  return Center(
    child: Text(
      "${title.toUpperCase()}",
      style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
          color: Colors.black,
          fontWeight: FontWeight.w600),
    ),
  );
}

//============================== Hadi nta3 l li fiha star wahd============================================================//
Widget Produitlist(BuildContext context, String nom, var _searchText) {
  return Container(
    child: StreamBuilder(
      stream: Firestore.instance
          .collection("users")
          .document(nom)
          .collection(nom)
          .snapshots(),
      builder: (context, snapshoot) {
        if (snapshoot.data == null)
          return Center(child: CircularProgressIndicator());
        int l = snapshoot.data.documents
            .map<Widget>((document) => New_column(context, document, 0))
            .toList()
            .length;
        switch (snapshoot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return Column(
              children: <Widget>[
                (_searchText == null || _searchText.toString() == "")
                    ? (l == 0
                        ? Container(height: 300,)
                        : GestureDetector(
                            child: title_bar(context, nom),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Profil_client(nom: nom)));
                            },
                          ))
                    : (makelist3(snapshoot, 0, _searchText, context).length == 0
                        ? Container()
                        : GestureDetector(
                            child: title_bar(context, nom),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Profil_client(nom: nom)));
                            },
                          )),
                Container(
                  height: (_searchText == null || _searchText.toString() == "")
                      ? (l == 0 ? 0 : ScreenUtil().setHeight(315))
                      : (makelist3(snapshoot, 0, _searchText, context).length ==
                              0
                          ? 0
                          : ScreenUtil().setHeight(315)),
                          
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return (_searchText == null ||
                              _searchText.toString() == "")
                          ? snapshoot.data.documents
                              .map<Widget>((document) =>
                                  New_column(context, document, index))
                              .toList()
                              .elementAt(index)
                          : makelist3(snapshoot, index, _searchText, context)
                              .elementAt(index);
                    },
                    itemCount:
                        (_searchText == null || _searchText.toString() == "")
                            ? (l < 7 ? l : 6)
                            : (makelist3(snapshoot, 0, _searchText, context)
                                        .length >
                                    7
                                ? 6
                                : makelist3(snapshoot, 0, _searchText, context)
                                    .length),
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            );
        }
      },
    ),
  );
}

List<Widget> makelist2(
    AsyncSnapshot snapshot, int index, var _searchText, BuildContext context) {
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
      return New_column(context, document, index);
    }
  }).toList();
}

List<Widget> makelist3(
    AsyncSnapshot snapshot, int index, var _searchText, BuildContext context) {
  List<Widget> list = [];
  for (int i = 0;
      i < makelist2(snapshot, index, _searchText, context).length;
      i++) {
    if (makelist2(snapshot, index, _searchText, context).elementAt(i) != null) {
      list.add(makelist2(snapshot, index, _searchText, context).elementAt(i));
    }
  }
  return list.toList();
}

Widget New_column(BuildContext context, var document, int index) {
  return GestureDetector(
    onTap: () => Navigator.push(context,
        MaterialPageRoute(builder: (context) => details_client(document))),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6),
              height: ScreenUtil().setHeight(250),
            width: MediaQuery.of(context).size.width/3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage.assetNetwork(
                placeholder: index % 5 == 0 && index > 4
                    ? "images/3.png"
                    : (index % 4 == 0 && index > 3
                        ? "images/4.png"
                        : (index % 3 == 0 && index > 2
                            ? "images/4.png"
                            : (index % 2 == 0 && index > 1
                                ? "images/1.png"
                                : (index % 1 == 0
                                    ? "images/3.png"
                                    : "images/1.png")))),
                image: document['image'],
                fit: BoxFit.fill,
              ),
            ),
          ),
          texter(context, document['title'])
        ],
      ),

  );
}

//============================== Hadi nta3 issm lcategorie fog kol oroduits============================================================//
Widget title_bar(BuildContext context, String title) {
  return Row(
    children: <Widget>[
      Expanded(
        flex: 8,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, bottom: 4),
          child: Text(
            "$title",
            style: GoogleFonts.oswald(
                textStyle: TextStyle(
                    fontSize: ScreenUtil().setSp(35), color: Colors.black87)),
          ),
        ),
      ),
      Expanded(
        flex: 4,
        child: Row(
          children: <Widget>[
            Text(
              "  savoir plus",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(32), color: Colors.black45),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: ScreenUtil().setSp(28),
              color: Colors.black45,
            )
          ],
        ),
      ),
    ],
  );
}

//============================== Hadi nta3 etafassil nta3 lcard nta3 lvendeur============================================================//
Widget vendeur_text_pageview(
    BuildContext context, String subtitle, String title) {
  return GestureDetector(
    //onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>profil())),
    child: Container(
      height: ScreenUtil().setHeight(88),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Text(
            "$title",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setHeight(35)),
          )),
          Expanded(
              child: Text(
            "$subtitle",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize:ScreenUtil().setHeight(35)),
          )),
        ],
      ),
    ),
  );
}

List<Widget> makelist4(
    AsyncSnapshot snapshot, int index, var _searchText, BuildContext context) {
  return snapshot.data.documents.map<Widget>((document) {
    if (document['nom']
            .toString()
            .toLowerCase()
            .contains(_searchText.toString()) ||
        document['nom']
            .toUpperCase()
            .toString()
            .contains(_searchText.toString()) ||
        document['nom'].toString().contains(_searchText.toString())) {
      return New_container(context, document, index);
    }
  }).toList();
}

List<Widget> makelist5(
    AsyncSnapshot snapshot, int index, var _searchText, BuildContext context) {
  List<Widget> list = [];
  for (int i = 0;
      i < makelist4(snapshot, index, _searchText, context).length;
      i++) {
    if (makelist4(snapshot, index, _searchText, context).elementAt(i) != null) {
      list.add(makelist4(snapshot, index, _searchText, context).elementAt(i));
    }
  }
  return list.toList();
}

//============================== Hadi nta3 hadi lpage view nta3 vendeurs============================================================//
Widget vendeurs_page(BuildContext context, var _searchText) {
  return StreamBuilder(
    stream: Firestore.instance.collection("vendeures").snapshots(),
    builder: (context, snapshoot) {
      if (snapshoot.data == null)
        return Center(child: CircularProgressIndicator());
      var l = snapshoot.data.documents
          .map<Widget>((document) => New_container(context, document, 0))
          .toList()
          .length;
      return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            (_searchText == null || _searchText.toString() == "")
                ? (l == 0
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom:5),
                                child: Text(
                                  "Vendeurs",
                                  style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                          fontSize: ScreenUtil().setSp(35), color: Colors.black87)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontSize:  ScreenUtil().setSp(33), color: Colors.black45),
                                  ),
//                        Icon(
//                          Icons.arrow_forward_ios,
//                          size: 12,
//                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ))
                : (makelist5(snapshoot, 0, _searchText, context).length == 0
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 8,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom:5),
                                child: Text(
                                  "Vendeurs",
                                  style: GoogleFonts.oswald(
                                      textStyle: TextStyle(
                                          fontSize:  ScreenUtil().setSp(37), color: Colors.black87)),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "",
                                    style: TextStyle(
                                        fontSize:  ScreenUtil().setSp(33), color: Colors.black45),
                                  ),
//                        Icon(
//                          Icons.arrow_forward_ios,
//                          size: 12,
//                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
            Container(
              height: (_searchText == null || _searchText.toString() == "")
                  ? (l > 7 ? ScreenUtil().setHeight(330) : l == 0 ? 0 : ScreenUtil().setHeight(330))
                  : (makelist5(snapshoot, 0, _searchText, context).length == 0
                      ? 0
                      : ScreenUtil().setHeight(330)),
              // width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return (_searchText == null || _searchText.toString() == "")
                      ? snapshoot.data.documents
                          .map<Widget>((document) =>
                              New_container(context, document, index))
                          .toList()
                          .elementAt(index)
                      : makelist5(snapshoot, index, _searchText, context)
                          .elementAt(index);
                },
                itemCount: (_searchText == null || _searchText.toString() == "")
                    ? (l > 7 ? 6 : l)
                    : (makelist5(snapshoot, 0, _searchText, context).length > 6
                        ? 6
                        : makelist5(snapshoot, 0, _searchText, context).length),
                pageSnapping: true,
                allowImplicitScrolling: false,
                scrollDirection: Axis.horizontal,
                controller: PageController(
                  initialPage: 0,
                  keepPage: true,
                  viewportFraction: 1,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Widget New_container(BuildContext context, var document, int index) {
  return GestureDetector(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  nom: document['email'],
                  nom2: document['nom'],
                ))),
    child: Container(
      //height: 150,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Image.asset(
                "images/vendeurvect.png",
                fit: BoxFit.fitHeight,
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // image:FadeInImage.assetNetwork(placeholder: null, image: null)
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Expanded(child: vendeur_text_pageview(context, document['nom'], "Nom")),
                    Expanded(
                                          child: vendeur_text_pageview(
                          context, document['number'], 'number'),
                    ),
                    Expanded(
                                          child: vendeur_text_pageview(
                          context, "Rue lakwass/bordj ghedir", "adresse"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
