import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import './components.dart';

class jibley_home extends StatefulWidget {
  @override
  _jibley_homeState createState() => _jibley_homeState();
}

class _jibley_homeState extends State<jibley_home> {
  TextStyle oswold = GoogleFonts.oswald();
  List nom = ["ahmed", "hohamed nabil", "mouslim messaoudi","nabil aguida"];
  TextEditingController jibleycode = TextEditingController();
  String healper = "" ;

  Color hintcolor = Colors.grey[500] ;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return SafeArea(
      child: Scaffold(

        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: ()=>showDialog(
                context: context,builder: (BuildContext context){
                  return AlertDialog(
                    content: TextField(
                      style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                      decoration : InputDecoration(
                        hintText: "code de vendeur",
                        hintStyle: TextStyle(
                         color: hintcolor
                        )
                      ),
                      controller: jibleycode,
                      onChanged: (valeu){
                        setState(() {
                          hintcolor = Colors.grey[500];
                        });
                      },

                    ),
                    actions: <Widget>[
                      FlatButton(
                        onPressed:()async{
                          if(jibleycode.text.length > 3){
                            await Firestore.instance.collection("code").add({
                    "code" : jibleycode.text.toString().trim()
                  });Navigator.pop(context);jibleycode.clear();
                          }else{
                            jibleycode.clear();
                            setState(() {
                              hintcolor =Colors.red ;
                            });
                          }


                }, child: Text("Enregistrer",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(32),

                    color: Colors.green[400]
                )
                ,
                ),
                        )
                    ],
                  );
                }
                )
            )
          ],
          title: Text(
            "JIBLEY",
            
            style: TextStyle(fontSize: ScreenUtil().setSp(40)),
          ),
          centerTitle: true,
          backgroundColor: Colors.pink[800],
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("jibli").snapshots(),
          builder: (context,snapshoot){
            List l = snapshoot.data.documents.map((document)=>sel3a(context,document)).toList();
            if (snapshoot.hasData == null)return Center(child:Text("il y'a pas pour le moment") );
         switch(snapshoot.connectionState){
           case ConnectionState.waiting :return Center(child: CircularProgressIndicator());
           default :    return ListView.builder(
          itemBuilder: (context, index) => l.elementAt(index),
          itemCount: l.length,

        );
         }
          },
        ),
      ),
    );
  }
}
