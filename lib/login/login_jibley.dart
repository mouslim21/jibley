import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibli/client/client_home.dart';
import 'package:jibli/jibley/jibley_home.dart';

import './animation2.dart';
import 'package:flutter/material.dart';
import './animation.dart';
import 'package:google_fonts/google_fonts.dart';

class login_jibley extends StatelessWidget {
  TextEditingController _password = TextEditingController();
  log(String Password) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: "jibli34@jibli34.com", password: Password);
      FirebaseUser user = result.user;

      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return Scaffold(
        backgroundColor: Colors.pink[900],
        body: SingleChildScrollView(
            child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/1.7,
                decoration: BoxDecoration(
                  gradient: LinearGradient(

                      colors: [Colors.pink[400], Colors.pink[900]]

                  ),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(360),
                      bottomLeft: Radius.circular(10)),
                ),
              ),
              Positioned(
                //  left: ScreenUtil().setWidth(20),
                  top: MediaQuery.of(context).size.height/14,
                  child: Text("JIBLEY",
                    style: GoogleFonts.pangolin(textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width*0.13,
                        color: Colors.white
                    )),
                  )
              ),
              Positioned(
                left: MediaQuery.of(context).size.width/3.8,
                top: MediaQuery.of(context).size.height/16,
                child: Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: Image.asset("images/man@2x.png",fit: BoxFit.fill,),),
              ),
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/2,left: 30,right: 30),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(1.8, Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10)
                            )
                          ]
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height/10,
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: TextField(
                            style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                            controller: _password,
                            keyboardType: TextInputType.visiblePassword ,
                            obscureText: true,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock,color: Colors.grey[400],size: MediaQuery.of(context).size.width*0.05),
                                border: InputBorder.none,
                                hintText: "Mote de passe",
                                hintStyle: TextStyle(color: Colors.grey[400],fontSize: MediaQuery.of(context).size.width*0.05)
                            ),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(height: MediaQuery.of(context).size.height/19,),
                    FadeAnimation(
                        2,
                        GestureDetector(
                          onTap: () async {
                            final password = _password.text.toString().trim();

                            FirebaseUser user = await log(password);
                            if (user != null) {
                              print("========================");
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return jibley_home();
                              }));
                            }
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(100),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Colors.pink[600],
                                  Colors.pink[900]
                                ])),
                            child: Center(
                              child: Text(
                                "Se cennecter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(34),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )),
                        
                    SizedBox(
                      height: ScreenUtil().setHeight(140),
                    ),
                    GestureDetector(
                      onTap: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>client_home())),
                                          child: FadeAnimation(
                          1.5,
                          Text(
                            "Commancer le shooping?",
                            style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(34)),
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        )));
  }
}
