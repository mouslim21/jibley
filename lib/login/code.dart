import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import './animation.dart';
import 'package:google_fonts/google_fonts.dart';
import './sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class code extends StatefulWidget {
  @override
  _codeState createState() => _codeState();
}

class _codeState extends State<code> {
  TextEditingController _code =TextEditingController() ;
  Color color = Colors.pink.shade500;
  var buttonstate = ButtonState.idle;
  
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
      height: ScreenUtil().setHeight(860),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.pink[400], Colors.pink[900]]),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(360),
            bottomLeft: Radius.circular(10)),
      ),
    ),
    Center(
    child: Padding(
    padding: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
    child: Text(
    "Entrer votre code ici !!",
    style:
    GoogleFonts.oswald(color: Colors.white, fontSize: ScreenUtil().setSp(75)),
    ),
    ),
    ),
    Padding(
    padding: EdgeInsets.only(top: ScreenUtil().setHeight(733), left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60)),
    child: Column(
    children: <Widget>[
    FadeAnimation(
    1.8,
    Container(
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(
    color: Color.fromRGBO(143, 148, 251, .2),
    blurRadius: 20.0,
    offset: Offset(0, 10))
    ]),
    child: Column(
    children: <Widget>[
    Container(
      height: ScreenUtil().setHeight(144),
    padding: EdgeInsets.all(8.0),
    child:Center(
      child:  TextField(
        style: TextStyle(fontSize: ScreenUtil().setSp(35)),
        controller: _code,
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(Icons.lock),
            border: InputBorder.none,
            hintText: "Code de confirmation",
            hintStyle:
            TextStyle(color: Colors.grey[400],)),

      ),
    ),
    )
    ],
    ),
    )),
    SizedBox(
    height: ScreenUtil().setHeight(65),
    ),
    FadeAnimation(2,  ProgressButton.icon(
        maxWidth: MediaQuery.of(context).size.width*0.80,
        minWidth: MediaQuery.of(context).size.width*0.80,
        height: MediaQuery.of(context).size.height*0.07,
        textStyle: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05,color: Colors.white),

        //  minWidth: 150.0,
    iconedButtons: {
    ButtonState.idle:
    IconedButton(
    text: "Se connecter",
    icon: Icon(Icons.send,color: Colors.white,size: MediaQuery.of(context).size.width*0.05,),
    color: color),
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
    final code = _code.text.toString().trim();
   QuerySnapshot querySnapshot = await Firestore.instance.collection("code").getDocuments();
    var list = querySnapshot.documents.map((e) => e['code']);
    var list2 = querySnapshot.documents.map((e) => e.documentID); 
    if(list.contains(code)){
       int a ;
      for(int i=0 ; i<list.length ; i++){
        list.elementAt(i)== code ? a = i : null ; 
      }
      await Firestore.instance.collection("code").document(list2.elementAt(a)).delete();
    setState(() {
    color = Colors.green.shade500;
    buttonstate = ButtonState.success;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => signup()),
    );
    });
    }
    if(!list.contains(code)){
    setState(() {
    buttonstate = ButtonState.fail;

    });
    }
    } ,
    state: buttonstate),),

    ],
    ),
    )
    ],
    ),
    )));
  }
}



