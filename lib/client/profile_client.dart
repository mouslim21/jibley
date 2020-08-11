import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'detail_clients.dart';

class Profil_client extends StatefulWidget {
  Profil_client({ this.nom});

   String nom;

  @override
  _Profil_clientState createState() => _Profil_clientState(nom: nom);
}

class _Profil_clientState extends State<Profil_client>
    with SingleTickerProviderStateMixin {
      _Profil_clientState({ this.nom});
       @override
  
  List<Widget> list=  [
           Container(
           margin: EdgeInsets.only(left: 8,top: 4),
           child: Text("Produits",style: GoogleFonts.montserrat(fontSize: 28,fontWeight: FontWeight.w600,color: Colors.black87,)),
         ),
              
///////////////////////////////////////////////////////////////////

        //////////////////////////////////////////////////////////////////////      
        
      
      
  ];

      Widget card(BuildContext context,var document,int index) {
        final heigh =MediaQuery.of(context).size.height;
        final width =MediaQuery.of(context).size.width;
        return GestureDetector(
          onTap: ()=>Navigator.push(context,
              MaterialPageRoute(builder: (context) => details_client(document)),
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

   String nom;
  TabController tabController;
 
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = new TabController(length: 5, vsync: this);
    print(nom);
  }

  String phone_nb = "0665348240";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       /* floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple[900],
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddNew(nom) ;
          })),
          child: Icon(Icons.add),
        ),*/
        body: StreamBuilder(
          stream: Firestore.instance.collection("users").document(nom).collection(nom).snapshots(),
          builder: (context ,snashot){
            if(snashot.hasData){
              return Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance.collection("users2").document(nom).snapshots(),
                builder: (context , snapshot){
                 if(snapshot.hasData){
                   return Container(
                padding: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5 ,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        blurRadius: 20,
                        spreadRadius: 10,
                      )
                    ],
                    gradient: LinearGradient(colors: [
                      Colors.pink[500],
                      Colors.pink[900]
                    ]),
//                  color: Colors.deepPurple[500],
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )),
                child: Column(
                  children: <Widget>[
                    Row(

                      children: <Widget>[
                        Expanded(
                          child: IconButton(

                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: ScreenUtil().setSp(36),
                            ),
                            onPressed: () {Navigator.pop(context);},
                          ),
                        ),
                        Expanded(child: Container(),),
                        Expanded(child: Container(),),
                        Expanded(child: Container(),),
                      ],
                    ),
                    Container(
                      height: ScreenUtil().setHeight(363),
                      width: ScreenUtil().setWidth(468),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.transparent,
                              spreadRadius: 2,
                            )
                          ]),
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage('images/shopavatar.png',),
                      ),
                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Text(
                        snapshot.data['nom'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(40),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //Text(
                     //" ",
                      //style: TextStyle(fontSize: 18, color: Colors.white),
                    //),
                   //Row(
                     // children: <Widget>[
                       // SizedBox(
                         // width: 10,
                        //),
                        /*FlatButton(
                            onPressed: () {},
                            child: Container(
                              height: 60,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("images/facebook3.png"))),
                            )),
                        FlatButton(
                            onPressed: () {},
                            child: Container(
                              height: 60,
                              width: 120,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage("images/instagram2.png"))),
                            ))*/
                     // ],
                   // ),
                  ],
                ),
              );
                 } 
                 else{return Center(child: CircularProgressIndicator(),);}
                 
                },
              ),
              SizedBox(
                height: 30,
              ),


               makelist(snashot,0).length==0? Center(child: Column(
                children: <Widget>[
                  Container(height: ScreenUtil().setHeight(160),),
                  Center(child: Icon(Icons.error,size: ScreenUtil().setSp(58),color:Colors.grey),),
                  Text("\nil y'a pas des produits pour le moment",
                    style: TextStyle(fontSize: ScreenUtil().setSp(38),color:Colors.grey),
                  )
                ],
              )
              ):                                                                                                                                                                                                                                                                                                                                                                                                                     Container(
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
        );
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
                     return  card(context , document,index);
          }
          else {return Container() ;}
    }).toList();
  }



}

