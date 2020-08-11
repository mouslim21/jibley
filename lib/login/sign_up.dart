import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jibli/vendeur/profile.dart';
import './animation.dart';
import 'package:google_fonts/google_fonts.dart';



class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController _nom = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController();
  TextEditingController _pass = new TextEditingController();
  TextEditingController _confpass = new TextEditingController();
  TextEditingController _fb = new TextEditingController();
  TextEditingController _insta = new TextEditingController();
  TextEditingController _address =TextEditingController();
  Color _nomc = Colors.grey.shade400;
  Color _emailc =  Colors.grey.shade400;
  Color _phonec =  Colors.grey.shade400;
  Color _passc =  Colors.grey.shade400;
  Color _confpassc =  Colors.grey.shade400;
  Color _fbc =  Colors.grey.shade400;
  Color _instac =  Colors.grey.shade400;
  sign(String name,String email,String password  ) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    try{

      AuthResult result = await auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      UserUpdateInfo info = UserUpdateInfo();
      info.displayName = name;
      user.updateProfile(info);
      await user.sendEmailVerification();
      return true;
    }catch(e){
      if(e is PlatformException) {
        if(e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          /*  setState(() {
            hinttext = "this accounte is already existe";
            _email.text = "";
            hintemail = Colors.red.shade600;
            hintemail2 = Colors.red.shade600;
            print("dddddddddd$e");
          });*/
        }
      };
      return false;
    }
  }
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
                    height: ScreenUtil().setHeight(860),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.pink[400], Colors.pink[900]]
                      ),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(360),
                          bottomLeft: Radius.circular(10)),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setHeight(42)),
                      child: Text("Creer votre compte",style: GoogleFonts.oswald(color: Colors.white,fontSize: ScreenUtil().setSp(78)),),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(210),left: ScreenUtil().setWidth(60),right: ScreenUtil().setWidth(60)),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(2, Container(
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
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  controller: _nom,
                                  onChanged: (value){
                                    setState(() {
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                      _fbc =  Colors.grey.shade400;
                                      _instac =  Colors.grey.shade400;
                                    });
                                  },
                                  onTap: (){
                                    _nomc = Colors.grey.shade400;
                                    _emailc =  Colors.grey.shade400;
                                    _phonec =  Colors.grey.shade400;
                                    _passc =  Colors.grey.shade400;
                                    _confpassc =  Colors.grey.shade400;
                                    _fbc =  Colors.grey.shade400;
                                    _instac =  Colors.grey.shade400;
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.person,color: _nomc),
                                      border: InputBorder.none,
                                      hintText: "Nom de vendeur",
                                      hintStyle: TextStyle(color: _nomc)
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  controller: _address,
                                  onChanged: (value){
                                    setState(() {
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                      _fbc =  Colors.grey.shade400;
                                      _instac =  Colors.grey.shade400;
                                    });
                                  },
                                  onTap: (){
                                    _nomc = Colors.grey.shade400;
                                    _emailc =  Colors.grey.shade400;
                                    _phonec =  Colors.grey.shade400;
                                    _passc =  Colors.grey.shade400;
                                    _confpassc =  Colors.grey.shade400;
                                    _fbc =  Colors.grey.shade400;
                                    _instac =  Colors.grey.shade400;
                                  },
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.person,color: _nomc),
                                      border: InputBorder.none,
                                      hintText: "location:cartier/citer/wilaya",
                                      hintStyle: TextStyle(color: _nomc)
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  onChanged: (value){
                                    setState(() {
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                      _fbc =  Colors.grey.shade400;
                                      _instac =  Colors.grey.shade400;
                                    });
                                  },
                                  onTap: (){
                                    _nomc = Colors.grey.shade400;
                                    _emailc =  Colors.grey.shade400;
                                    _phonec =  Colors.grey.shade400;
                                    _passc =  Colors.grey.shade400;
                                    _confpassc =  Colors.grey.shade400;
                                    _fbc =  Colors.grey.shade400;
                                    _instac =  Colors.grey.shade400;
                                  },
                                  controller: _phone,
                                  keyboardType: TextInputType.phone ,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.phone,color: _phonec),
                                      hintText: "Numero de telephone",
                                      hintStyle: TextStyle(color: _phonec)
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  onChanged: (value){
                                    setState(() {
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                      _fbc =  Colors.grey.shade400;
                                      _instac =  Colors.grey.shade400;
                                    });
                                  },
                                  onTap: (){
                                    _nomc = Colors.grey.shade400;
                                    _emailc =  Colors.grey.shade400;
                                    _phonec =  Colors.grey.shade400;
                                    _passc =  Colors.grey.shade400;
                                    _confpassc =  Colors.grey.shade400;
                                    _fbc =  Colors.grey.shade400;
                                    _instac =  Colors.grey.shade400;
                                  },
                                  controller: _email,
                                  keyboardType: TextInputType.emailAddress ,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.email,color: _emailc),
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: _emailc)
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  onChanged: (value){
                                    setState(() {
                                      _nomc = Colors.grey.shade400;
                                      _emailc =  Colors.grey.shade400;
                                      _phonec =  Colors.grey.shade400;
                                      _passc =  Colors.grey.shade400;
                                      _confpassc =  Colors.grey.shade400;
                                      _fbc =  Colors.grey.shade400;
                                      _instac =  Colors.grey.shade400;
                                    });
                                  },
                                  onTap: (){
                                    _nomc = Colors.grey.shade400;
                                    _emailc =  Colors.grey.shade400;
                                    _phonec =  Colors.grey.shade400;
                                    _passc =  Colors.grey.shade400;
                                    _confpassc =  Colors.grey.shade400;
                                    _fbc =  Colors.grey.shade400;
                                    _instac =  Colors.grey.shade400;
                                  },
                                  controller: _pass,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword ,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.lock,color: _passc),
                                      hintText: "Mot de passe",
                                      hintStyle: TextStyle(color: _passc)
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  keyboardType: TextInputType.visiblePassword ,
                                  controller: _confpass,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.lock,color:_passc),
                                      hintText: "Confermer le mot de passe",
                                      hintStyle: TextStyle(color: _passc)
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[100]))
                                ),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  controller: _insta,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.supervisor_account,color: _instac),
                                      hintText: "Lien instagram",
                                      hintStyle: TextStyle(color: _instac)
                                  ),
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(120),
                                padding: EdgeInsets.all(8.0),
                                child: TextField(
                                  style: TextStyle(fontSize: ScreenUtil().setSp(31)),
                                  controller: _fb,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      icon: Icon(Icons.supervisor_account,color: _fbc,),
                                      hintText: "Lien facebook",
                                      hintStyle: TextStyle(color: _fbc)
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                        SizedBox(height: ScreenUtil().setHeight(60),),

                        GestureDetector(
                          onTap: ()async{
                            final email = _email.text.toString().trim();
                            final pass = _pass.text.toString().trim();
                            final confpass = _confpass.text.toString().trim();
                            final nom = _nom.text.toString().trim();
                            final fb = _fb.text.toString().trim();
                            final insta = _insta.text.toString().trim();
                            final phone = _phone.text.toString().trim();
                            final address = _address.text.toString().trim();

                            bool result =false;
                            if(pass == confpass && nom.length > 3 && pass.length >7 && (phone.length==10||phone.length==9) && nom.length>2 ){
                              result = await sign(nom , email , pass);
                            }/*else{
                            setState(() {
                                hintpassword = Colors.red.shade600;
                              });
                            }
                            if(name.length < 3 ){
                              hintname = Colors.red.shade600;

                            }
                            if(email ==null || email ==""){
                              hintemail = Colors.red.shade600;

                            }*/
                            if(result){
                              Firestore.instance.collection(email).document(email).setData({
                                "nom":nom,
                                "email":email,
                                "insta":insta,
                                "fb":fb,
                                "number":phone,
                                "address":address
                              });
                              Firestore.instance.collection("vendeures").document().setData({
                                "nom":nom,
                                "email":email,
                                "insta":insta,
                                "fb":fb,
                                "number":phone,
                                "address":address
                              });
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)  {
                                return MyHomePage(nom: email,nom2: nom,);
                              }));
                            }else{
                               setState(() {
                                 if(nom.length<3){
                                   _nomc = Colors.red;
                                 }
                                 if(email==null||email=="")_emailc = Colors.red;
                                 if(phone.length!=10||phone.length==9)_phonec= Colors.red;
                                 if(pass.length<8 ||confpass!=pass){
                                   _passc = Colors.red;
                                   _confpassc = Colors.red;
                                 }
                               });
                            }

                          },
                          child: FadeAnimation(1, Container(
                            height: ScreenUtil().setHeight(100),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                    colors: [Colors.pink[400], Colors.pink[900]]
                                )
                            ),
                            child: Center(
                              child: Text("S'inscrire", style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(34) ,fontWeight: FontWeight.bold),),
                            ),
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


