import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jibli/home2.dart';
import 'package:url_launcher/url_launcher.dart';

import 'addnew.dart';
import 'details.dart';

class MyHomePage extends StatefulWidget {
  var nom2;
  MyHomePage({ this.nom,this.nom2});

   String nom;

  @override
  _MyHomePageState createState() => _MyHomePageState(nom: nom,nom2: nom2);
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
      var nom2;
      _MyHomePageState({ this.nom,this.nom2});
       @override
  
  List<Widget> list=  [
      Container(
      margin: EdgeInsets.only(left: 8,top: 4),
      child: Text("Produits",style: GoogleFonts.montserrat(fontSize:30,fontWeight: FontWeight.w600,color: Colors.black87,)),
      ),
        //////////////////////////////////////////////////////////////////////
  ];
      Widget card(BuildContext context,var document,int index,var nom) {
        final heigh =MediaQuery.of(context).size.height;
        final width =MediaQuery.of(context).size.width;
        return GestureDetector(
          onTap: ()=>Navigator.push(context,
            MaterialPageRoute(builder: (context) => details(document,nom)),
          ),
          child: Center(
            child: Container(
              height: heigh * 0.41,
              width: width * 0.472,
              margin: EdgeInsets.only(bottom: heigh*0.05),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(15)
                  ),
                  border: Border.all(
                      color: Colors.pink[500],
                      width: 2
                  )
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: heigh * 0.1404134094806054,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)
                        ),
                        gradient: LinearGradient(
                            colors: [Colors.pink[900],Colors.pink[600]]
                        )
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Hero(
                                tag: document['image'],
                                child: Container(
                                  width: width * 0.38,
                                  height: heigh*0.23,
                                  decoration: BoxDecoration(
                                    border:Border.all(
                                        width: 2,
                                        color: Colors.white
                                    ),
//                                      image: DecorationImage(
//                                          image: NetworkImage(document["image"]),
//                                          fit: BoxFit.fill
//                                      )
                                  ),
                                  child:  FadeInImage.assetNetwork(
                                    placeholder: index % 5 == 0 && index > 4
                                        ? "images/1.png"
                                        : (index % 4 == 0 && index > 3
                                        ? "images/2.png"
                                        : (index % 3 == 0 && index > 2
                                        ? "images/3.png"
                                        : (index % 2 == 0 && index > 1
                                        ? "images/4.png"
                                        : (index % 1 == 0
                                        ? "images/5.png"
                                        : "images/5.png")))),
                                    image: document['image'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top: heigh * 0.2430232087164324),
                            child: Center(
                                child: Text(
                                  document['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                      fontSize: width*0.05*1.1),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: heigh * 0.2835270768358378),
                            child: Center(
                                child: Text(
                                  document['prix'],
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: width*0.05),
                                )),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.pink[500],
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8))
                          ),

                          child: Center(
                            child: Text(
                              "plus de détails",style: TextStyle(color: Colors.white,fontSize: width*0.05),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }
////////////
        static Widget Mypadding(BuildContext context ,var  document,int index,String nom) {
         return Padding(
              padding: const EdgeInsets.only(left: 20.0,),
              child: GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => details(document,nom))),
                child: Container(
                  height: 315,
                  child: Stack(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        elevation: 6,
                        child: Hero(
                          tag: document['image']+document['title']+document['prix'],
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                            ),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(20),
                               child: FadeInImage.assetNetwork(placeholder: index%5==0&&index>4?"images/1.png"
                                 :(index%4==0&&index>3?"images/2.png":(index%3==0&&index>2?"images/3.png":(index%2==0&&index>1?"images/4.png":(index%1==0?"images/5.png":"images/5.png")))),
                                  image: document['image'],fit: BoxFit.fill,)),
                            height: 260,
                            width: 170,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 8,
                        top: 200,
                        bottom: 20,        
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey[200],
                            ),
                            height: 80,
                            width: 120,
                
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 20,
                                  child: Text(
                                    document['title'],
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                Positioned(
                                  top: 30,
                                  left: 19,
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 20,
                                  child: Text(
                                    document["prix"],
                                    style: TextStyle(
                                        color: Colors.purple[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 110,
                        top: 235,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.pinkAccent,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            height: 40,
                            width: 40,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
       }
   String nom;
  TabController tabController;
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
    print(nom);
  }

  String phone_nb ;
  String address;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return SafeArea(
      child: Scaffold(

        body: StreamBuilder(
          stream: Firestore.instance.collection(nom).snapshots(),
          builder: (context ,snashot){
            if(snashot.hasData==null)return Center(child: CircularProgressIndicator(),);
            if(snashot.hasData){
              return SafeArea(
                child:StreamBuilder(
                  stream: Firestore.instance.collection(nom).document(nom).snapshots(),
                  builder: (context,snaapshoot){
                    if(snaapshoot.hasData==null)return Center(child: CircularProgressIndicator(),);
                    switch(snaapshoot.connectionState){
                      case ConnectionState.waiting:
                        return Center(child: CircularProgressIndicator(),);
                        default:
                        return Scaffold(
                        floatingActionButton: FloatingActionButton(
                          backgroundColor: Colors.pink[600],
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context){
                            return AddNew(nom,nom2,snaapshoot.data['number'],snaapshoot.data['address']) ;
                          })),
                          child: Icon(Icons.add),
                        ),
                        body: Container(
                          color: Colors.white,
                          child: ListView(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3.2,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.7),
                                        blurRadius: 20,
                                        spreadRadius: 10,
                                      )
                                    ],
                                    gradient: LinearGradient(
                                        colors: [Colors.pink[400], Colors.pink[900]]
                                    ),
//                  color: Colors.deepPurple[500],
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    )),
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.85),
                                        child: Icon(
                                          Icons.arrow_back,
                                          size: ScreenUtil().setSp(60),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
//                                      Row(
//                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                        children: <Widget>[
//                                          Padding(
//                                            padding: const EdgeInsets.only(left: 95),
//                                            child: Container(
//                                              height: 180,
//                                              width: 200,
//                                              decoration: BoxDecoration(
//                                                  color: Colors.transparent,
//                                                  borderRadius: BorderRadius.circular(20),
//                                                  boxShadow: [
//                                                    BoxShadow(
//                                                      color: Colors.transparent,
//                                                      spreadRadius: 2,
//                                                    )
//                                                  ]),
//                                              child: Image(
//
//                                                image: AssetImage('images/shopavatar.png',),
//                                              ),
//                                            ),
//                                          ),
//                                        ],
//                                      ),
//                    SizedBox(
//                      height: 10,
//                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Text(
                                        snaapshoot.data['nom'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(42),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      snaapshoot.data['number'],
                                      style: TextStyle(fontSize: ScreenUtil().setSp(42), color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(20),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: ScreenUtil().setWidth(80),
                                        ),
                                        FlatButton(
                                            onPressed: () async{
                                              var url = 'https://facebook.com';

                                              if (await canLaunch(url)) {
                                                await launch(
                                                  url,
                                                  universalLinksOnly: true,
                                                );
                                              } else {
                                                throw 'There was a problem to open the url: $url';
                                              }
                                              String fbProtocolUrl;
                                              if (Platform.isIOS) {
                                                fbProtocolUrl = snaapshoot.data['fb'];
                                              } else {
                                                fbProtocolUrl = snaapshoot.data['fb'];
                                              }

                                              String fallbackUrl = snaapshoot.data['fb'];

                                              try {
                                                bool launched = await launch(fbProtocolUrl, forceSafariVC: false);

                                                if (!launched) {
                                                  await launch(fallbackUrl, forceSafariVC: false);
                                                }
                                              } catch (e) {
                                                await launch(fallbackUrl, forceSafariVC: false);
                                              }
//                              const url = 'https://facebook.com';
//                              if (await canLaunch(url)) {
//                              await launch(url);
//                              } else {
//                              throw 'Could not launch $url';
//                              }
                                            },
                                            child: Container(
                                              height: ScreenUtil().setHeight(120),
                                              width: ScreenUtil().setWidth(240),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                      AssetImage("images/facebook3.png"))),
                                            )),
                                        FlatButton(
                                            onPressed: () async{
                                              var url = snaapshoot.data['insta'];

                                              if (await canLaunch(url)) {
                                                await launch(
                                                  url,
                                                  universalLinksOnly: true,
                                                );
                                              } else {
                                                throw 'There was a problem to open the url: $url';
                                              }
                                            },
                                            child: Container(
                                              height: ScreenUtil().setHeight(120),
                                              width: ScreenUtil().setWidth(240),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image:
                                                      AssetImage("images/instagram2.png"))),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              ,
                              SizedBox(
                                height: ScreenUtil().setHeight(60),
                              ),
                              makelist(snashot,0).length==1? Center(child: Column(
                                children: <Widget>[
                                  Container(height: ScreenUtil().setHeight(160),),
                                  Center(child: Icon(Icons.error,size: ScreenUtil().setSp(58),color:Colors.grey),),
                                  Text("\nil y'a pas des produits pour le moment",
                                    style: TextStyle(fontSize: ScreenUtil().setSp(38),color:Colors.grey),
                                  )
                                ],
                              )
                              ): Container(
                                // height: 2000,
                                child: CustomScrollView(
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  slivers: <Widget>[
                                    SliverStaggeredGrid.countBuilder(

                                      crossAxisCount: 2 ,
                                      staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      itemCount: makelist(snashot,0).length+1,
                                      itemBuilder: (context, index){
                                        return index==0? list[0]: makelist(snashot,index).elementAt(index-1)==Container()?
                                        null :makelist(snashot,index).elementAt(index-1);
                                      } ,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    };
                  },
                ),
              );
              setState(() {
                phone_nb =snashot.data['number'];
                address =snashot.data['address'];
              });
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          },
        ),
      ),
    );
  }

  List<Widget> makelist(AsyncSnapshot snapshot,int index) {
   
    return snapshot.data.documents.map<Widget>((document) {
          if(document.documentID.toString() != nom){
                     return  card(context , document,index,nom);
          }
          else {return Container() ;}
    }).toList();
  }



}


