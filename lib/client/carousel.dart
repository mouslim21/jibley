
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import 'detail_clients.dart';

class Carroussel extends StatefulWidget {
  var _searchText;
  Carroussel(this._searchText);
  @override
  _CarrousselState createState() => new _CarrousselState(_searchText);
}

class _CarrousselState extends State<Carroussel> {
  var _searchText;
  _CarrousselState(this._searchText);
  PageController controller;
  int currentpage = 1;


  @override
  initState() {
    super.initState();
    controller = new PageController(
      initialPage: currentpage,
      keepPage: false,
      viewportFraction: 0.5,
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new StreamBuilder(
        stream: Firestore.instance.collection("users").document("Kids").collection("Kids").snapshots(),
        builder: (context,snapshoot){
          if(snapshoot.data==null)return Center(child:CircularProgressIndicator());
          int l =snapshoot.data.documents.map<Widget>((document)=>builder(document,0)).toList().length;
          return Container(
            height: (_searchText ==null || _searchText.toString() =="") ?(l==0?0 :
          ScreenUtil().setHeight(500)):(makelist3(snapshoot, 0, _searchText, context).length==0?0:
          ScreenUtil().setHeight(500)),
          
            child: PageView.builder(
                itemCount: (_searchText ==null || _searchText.toString() =="") ?(l<7?l :6):(makelist3(snapshoot, 0, _searchText, context).length>7?6:
                makelist3(snapshoot, 0, _searchText, context).length),
                onPageChanged: (value) {
                  setState(() {
                    currentpage = value;
                  });
                },
                controller: controller,
                itemBuilder: (context, index) =>
                (_searchText ==null || _searchText.toString() =="")?
                snapshoot.data.documents.map<Widget>((document)=>builder(document,index)).toList().elementAt(index)
                    :makelist3(snapshoot, index, _searchText, context).elementAt(index)
            ),
          );
        },
      ),
    );

  }
  List<Widget> makelist2(AsyncSnapshot snapshot,int index, var _searchText,BuildContext context) {
    return snapshot.data.documents.map<Widget>((document) {
      if(document['title'].toString().toLowerCase().contains(_searchText.toString())|| document['title'].toUpperCase().toString().contains(_searchText.toString())
          || document['title'].toString().contains(_searchText.toString()))   {return builder( document,index);}
    }).toList();
  }
  List<Widget> makelist3(AsyncSnapshot snapshot,int index,var _searchText,BuildContext context) {
    List<Widget> list = [];
    for(int i=0 ; i<makelist2(snapshot,index,_searchText,context).length;i++){
      if(makelist2(snapshot,index,_searchText,context).elementAt(i)!= null){list.add(makelist2(snapshot,index,_searchText,context).elementAt(i));}
    }
    return list.toList();
  }

  Widget builder(var document,int index) {
    return new AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        double value = 1.0;
        if (controller.position.haveDimensions) {
          value = controller.page - index;
          value = (1 - (value.abs() * .5)).clamp(0.0, 1.0);
        }

        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>details_client(document)));
          },
          child: new Center(
            child: new SizedBox(
              height: Curves.easeOut.transform(value) * 900,
              width: Curves.easeOut.transform(value) * ScreenUtil().setWidth(310),
              child: child,
            ),
          ),
        );
      },
      child: Center(
        child: new Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(15)
              ),
              border: Border.all(
                color: Colors.pink[900],
                width: 3,
              ),
              color: Colors.grey[100],
              /*boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius:22,
                  spreadRadius: 0.5,
                )
              ]*/

          ),
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Center(
                    child: Container(
                      height:ScreenUtil().setHeight(330) ,
                      width:  ScreenUtil().setWidth(260),
                      child:  FadeInImage.assetNetwork(
                          placeholder: index%5==0&&index>4?"images/1.png"
                                     :(index%4==0&&index>3?"images/2.png":(index%3==0&&index>2?
                                     "images/3.png":(index%2==0&&index>1?"images/4.png":(index%1==0?
                                     "images/5.png":"images/2.png")))) ,
                          image: document["image"],
                         // fadeOutDuration: Duration(milliseconds: 50),
                          fit: BoxFit.fill,
                        ) ,
                      decoration: BoxDecoration(
                        // image:FadeInImage.assetNetwork(placeholder: null, image: null)

                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),),
              ),
              currentpage==index? Container(
                margin: EdgeInsets.only(top: 6,right: 2,left: 2),
                height: ScreenUtil().setHeight(120),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                                          child: Column(
                        children: <Widget>[
                          Text(document['title'],
                              style:  GoogleFonts.oswald(textStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(29),
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87
                              ))
                          ),
                          Text(document["prix"],
                              style:  GoogleFonts.oswald(textStyle: TextStyle(
                                  fontSize: ScreenUtil().setSp(25),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green[600]
                              ))
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                     // padding: const EdgeInsets.only(left: 30,bottom: 10),
                      child: Container(
                        height: ScreenUtil().setHeight(80),
                        width: ScreenUtil().setHeight(80),
                        decoration: BoxDecoration(
                            color: Colors.pink[800],
                     /*       borderRadius: BorderRadius.all(
                                Radius.circular(10)
                            ),*/
                     /*       boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400],
                                  blurRadius: 8,
                                  offset: Offset(4,4),
                                  spreadRadius: 2
                              )
                            ]*/
                        ),
                        child: Icon(Icons.arrow_forward,color: Colors.white,
                        size: ScreenUtil().setSp(36),),
                      ),
                    )
                  ],
                ),
              ):Center(child: Container(height: 0.5,))
            ],
          ),
        ),
      ),
    );
  }
}
