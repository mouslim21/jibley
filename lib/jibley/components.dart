import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';

 void call(var tel){
   launch((tel));
 }
void _launchMapsUrl(double lat, double lon) async {
  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
/*class sel3a_card extends StatefulWidget {
  BuildContext context;
  var document;
  sel3a_card(this.context,this.document);
  @override
  _sel3a_cardState createState() => _sel3a_cardState(context,document);
}

class _sel3a_cardState extends State<sel3a_card> {
  BuildContext context;
  var document;
  _sel3a_cardState(this.context,this.document);
  List<String> labels = ["VENDEUR", "CLIENT"];
  int currentIndex = 0;

}*/

  
  Widget sel3a(BuildContext context,var document) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return document != null ?  Dismissible(
      onDismissed: (value){
          Firestore.instance.collection("jibli").document(document.documentID).delete();
      },
      direction: DismissDirection.startToEnd,
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.green[400],
        child: Padding(
          padding:  EdgeInsets.only(left: ScreenUtil().setWidth(40)),
          child: Icon(Icons.check,color: Colors.white,size: ScreenUtil().setSp(100),),
        ),
      ),
      key: UniqueKey(),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          height: ScreenUtil().setHeight(460),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(300),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        document['image']
                      ),
                    )
                ),
              ),
              Expanded(
                child: PageView(
                  pageSnapping: true,
                  allowImplicitScrolling: false,
                  scrollDirection: Axis.horizontal,
                  controller: PageController(
                    initialPage: 0,
                    keepPage: true,
                    viewportFraction: 1,
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                             padding: EdgeInsets.only(top:10,bottom: 2),                           
                            child: Text("PRODUIT",style: TextStyle( fontSize: ScreenUtil().setSp(32),fontWeight: FontWeight.w600),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              vendeur_text_pageview(
                                    context, document['nomp'], "nom de produit"),
                              vendeur_text_pageview(
                                    context, document["detaille"], "details"),
                              vendeur_text_pageview(
                                    context, document['prix'], "prix"),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top:10,bottom: 2),
                            child: Text("VENDEUR",style: TextStyle( fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w600),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              vendeur_text_pageview(
                                    context, document['7anout'], "nom de vendeur"),
                              GestureDetector(
                                  onTap:(){call("tel:"+document["number2"]);},
                                  child: vendeur_text_pageview(
                                      context, document['number2'], "Numero de telephone"),
                                ),
                              GestureDetector(
                                  onTap: ()async=>await _launchMapsUrl(20,50),
                                  child: vendeur_text_pageview(
                                      context,document["address2"], "adresse"),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.only(top:10,bottom: 2),                            
                            child: Text("CLIENT",style: TextStyle( fontSize: ScreenUtil().setSp(34),fontWeight: FontWeight.w600),)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              vendeur_text_pageview(
                                    context, document["nom"], "nom de client"),
                              vendeur_text_pageview(
                                    context, document['number'], "Numero de telephone"),
                              vendeur_text_pageview(
                                    context, document["address"], "adresse"),
                            ],
                          ),
                        )
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ):Center(child: Container(child: Text("il y'a pas pour le moment"),),);
  }


Widget vendeur_text_pageview(
BuildContext context, String subtitle, String title) {
  ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
  return Container(
    height: ScreenUtil().setHeight(110),
    alignment: Alignment.topLeft,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Text(
          "$title",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(32)),
        )),
        Expanded(
            child: Text(
          "$subtitle",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: ScreenUtil().setSp(32)),
        )),
      ],
    ),
  );
}
