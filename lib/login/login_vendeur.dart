import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibli/login/code.dart';
import 'package:jibli/vendeur/profile.dart';
import './animation.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:google_fonts/google_fonts.dart';




class login extends StatefulWidget {

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  log(String email , String Password) async{
    FirebaseAuth _auth = FirebaseAuth.instance;

    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: Password);
      FirebaseUser user = result.user;
      setState(() {
                                buttonstate = ButtonState.loading;
                              });
      return user;
    }catch(e){
      print(e);
      return null;
    }
  }
  Color color = Colors.pink.shade500;
  var buttonstate =ButtonState.idle;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    return Scaffold(
        backgroundColor: Colors.white,
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
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height/10,
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: Center(
                                  child: TextField(
                                    style: TextStyle(fontSize: ScreenUtil().setSp(34)),
                                    controller: _email,
                                    keyboardType: TextInputType.emailAddress ,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.email,color: Colors.grey[400],size: MediaQuery.of(context).size.width*0.05),
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(color: Colors.grey[400],fontSize: MediaQuery.of(context).size.width*0.05)
                                    ),
                                  ),
                                ),
                              ),
                              Container(
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
                              )
                            ],
                          ),
                        )),
                        SizedBox(height: MediaQuery.of(context).size.height/19,),
                        FadeAnimation(2,  ProgressButton.icon(
                            maxWidth: MediaQuery.of(context).size.width*0.80,
                            minWidth: MediaQuery.of(context).size.width*0.80,
                            height: MediaQuery.of(context).size.height*0.07,
                            textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color: Colors.white),
                            iconedButtons: {
                          ButtonState.idle:
                          IconedButton(
                              text: "Se connecter",
                              icon: Icon(Icons.send,color: Colors.white,size: MediaQuery.of(context).size.width*0.05),
                              color: color,
                          ),
                          ButtonState.loading:
                          IconedButton(
                              text: "Loading",
                              color: Colors.deepPurple.shade700),
                          ButtonState.fail:
                          IconedButton(
                              text: "échoué".toUpperCase(),
                              icon: Icon(Icons.cancel,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),
                              color: Colors.red.shade300),
                          ButtonState.success:
                          IconedButton(
                              text: "Succés".toUpperCase(),
                              icon: Icon(Icons.check_circle,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),
                              color: color)
                        },
                            onPressed:()async{
                              final email = _email.text.toString().trim();
                              final password = _password.text.toString().trim();

                              FirebaseUser user = await log(email , password);

                              if(user != null){
                                print("========================");
                                print(user.displayName);
                                setState(() {
                                  color = Colors.green.shade500;
                                  buttonstate = ButtonState.success;

                                });
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)  {
                                  return MyHomePage(nom: email,nom2: user.displayName,);}));
                              };
                              if(user==null){
                                setState(() {
                                  buttonstate = ButtonState.fail;

                                });
                              }
                            } ,
                            state: buttonstate),),
                        SizedBox(height: MediaQuery.of(context).size.height/13,),

                        GestureDetector(
                            onTap:(){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>code()));
                            } ,
                            child: FadeAnimation(1.5, Container(
                              padding: EdgeInsets.all(3),
//                              decoration: BoxDecoration(
//                                  border: Border(
//                                    bottom: BorderSide(width: 2,color: Colors.grey)
//                                  ),
//                                  borderRadius: BorderRadius.circular(15)
//                              ),
                              child: Text("S'inscrire", style: TextStyle(color: Colors.pink,
                                  textBaseline: TextBaseline.alphabetic,
                                  decoration: TextDecoration.underline,
                                  fontSize: MediaQuery.of(context).size.width*0.05
                                 // fontSize: ScreenUtil().setSp(40)
                              ),
                              ),
                            ))),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}

