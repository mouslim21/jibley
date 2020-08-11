import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:photo_view/photo_view.dart';
import '../client/client_home.dart';

class AddNew extends StatefulWidget {
  String nom;
  String nom2;
  String number;
  String address;
  AddNew(this.nom,this.nom2,this.number,this.address);
  @override
  _AddNewState createState() => _AddNewState(nom,nom2,number,address);
}
class Item {
  const Item(this.name,this.icon);
  final String name;
  final Icon icon;
}
class _AddNewState extends State<AddNew> {
    static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['ecommerce', 'shopping'],
    childDirected: true,
  );
  InterstitialAd _interstitialAd ;
    InterstitialAd createinterstialAd() {
    return InterstitialAd(
      //adUnitId: InterstitialAd.testAdUnitId,
        adUnitId: "ca-app-pub-3019770614934948/3162944376",
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("interstitialAd : $event");
        });
  }
  String address;
  var nom;
    var nom2;
  String number;
  _AddNewState(this.nom,this.nom2,this.number,this.address);
    Item selectedUser;
  List<Item> users = <Item>[
    const Item('Famme',Icon(Icons.pregnant_woman,color:  const Color(0xFF167F67),)),
    const Item('Homme',Icon(Icons.wc,color:  const Color(0xFF167F67),)),
    const Item('Kids',Icon(Icons.format_indent_decrease,color:  const Color(0xFF167F67),)),
    const Item('Informatiques',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
    const Item('Smartphone',Icon(Icons.phone,color:  const Color(0xFF167F67),)),

  ];
  File _image;
TextEditingController _nom = TextEditingController();
TextEditingController _prix = TextEditingController();
TextEditingController _details = TextEditingController();
var  nomcolor= Colors.blueGrey;
Color prixcolor = Colors.blueGrey;
Color detailscolor = Colors.blueGrey;
 var a = false;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1440, allowFontScaling: false);
    Future uploadPic(BuildContext context) async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){return flare();}));

      String fileName = basename(_image.path);
      StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
       StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
       StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;

        var b = await Firestore.instance.collection(nom)
      .add({
        "nom":nom2,
        'title': _nom.text.toString().trim(),
        'prix':_prix.text.toString().trim(),
        'description': _details.text.toString().trim(),
        'image':await firebaseStorageRef.getDownloadURL(),
        'imagesupp':fileName,
        'category':selectedUser.name,
          "number":number,
          "address":address
        });
      
   
       await Firestore.instance.collection("users").document(selectedUser.name).collection(selectedUser.name).
       document(b.documentID).setData(
         {
        "nom":nom2,
        'title': _nom.text.toString().trim(),
        'prix':_prix.text.toString().trim(),
        'description': _details.text.toString().trim(),
        'image':await firebaseStorageRef.getDownloadURL(),
        'imagesupp':fileName,
        'category':selectedUser.name,
         "number":number,
           "address":address
      }
       );
       await Firestore.instance.collection("users2").document(selectedUser.name).setData({"nom":selectedUser.name});
      // await Firestore.instance.collection("users").document(selectedUser.name).updateData({"icon":"icon"});
       setState(() {
          print("Profile Picture uploaded");
       });


    }
   
    Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery) ;

      setState(() {
        _image = image;
         
      });
    }
        return SafeArea(
          child: Scaffold(
            body: Container(
              width: double.infinity,
           
              //height: double.infinity,
              //width: double.infinity,
              child:ListView(
                children: <Widget>[
                   Container(
                     height: ScreenUtil().setHeight(1655),
                    child: Stack(
                children: <Widget>[
                 
                 
                     Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: (){
                         (_image == null  )?getImage():  
                         Navigator.push(context, MaterialPageRoute(builder: (context)  {
                                return Photo(images:_image,);
                              }));
                                             },
                         child:Hero(tag: "hero", 
                         child:  Container(
                         height: ScreenUtil().setHeight(610),
                         width: MediaQuery.of(context).size.width,
                        
                         decoration: BoxDecoration(
                        color:Colors.grey.shade200,
                         /*  borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 1,
                              )]*/
                            
                         ),
                        child: 
                            (_image == null) ? Container(
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: ScreenUtil().setHeight(100),),
                                  Icon(Icons.image,size: ScreenUtil().setSp(240),),
                                  SizedBox(height: ScreenUtil().setHeight(30),),
                                  Text("No Image Selected ...",style: TextStyle(fontSize: ScreenUtil().setSp(34),color: Colors.grey.shade600),)
                                ],
                              ),
                            ):Image.file(
                                _image,
                                fit: BoxFit.fill,
                              ),
                     )),
                      ),
                  ),
                   Positioned(
                      top: ScreenUtil().setHeight(590),
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.only(top:ScreenUtil().setHeight(20),left :20,right:20 ),
                       height: ScreenUtil().setHeight(940),
                       child: Column(
                         children: <Widget>[
                           
                           Container(
                               height: ScreenUtil().setHeight(120),
                               padding: EdgeInsets.all(8),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(12),
                               color: Colors.grey.shade200,
                             ),
                             margin: EdgeInsets.only(bottom: 10,top: 30,),
                             child: Center(
                               child: TextField(
                                 style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),
                                 onChanged: (_nom){
                    setState(() {
                      nomcolor = Colors.blueGrey;
                      detailscolor = Colors.blueGrey;
                      prixcolor = Colors.blueGrey;
                    });
                  },
                  onTap: (){
                    setState(() {
                     nomcolor = Colors.blueGrey;
                      detailscolor = Colors.blueGrey;
                      prixcolor = Colors.blueGrey;
                    });
                  },
                               controller:_nom,
                               decoration: InputDecoration(
                                 border: InputBorder.none,
                                 hintText: "Entrer nom de produit ",
                                 hintStyle: TextStyle(color: nomcolor,fontSize:  MediaQuery.of(context).size.width*0.04),
                         ),
                       ),
                             )),
                       Row(
                         children: <Widget>[
                           Flexible(
                             flex: 4,
                             child: Container(
                               height: ScreenUtil().setHeight(120),
                               width: ScreenUtil().setWidth(800),
                         padding: EdgeInsets.all(8),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                           color: Colors.grey.shade200,
                         ),
                         margin: EdgeInsets.only(bottom: 10,top: 10,),
                         child: Center(
                           child: TextField (
                             style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04),
                             onChanged: (_nom){
                    setState(() {
                      nomcolor = Colors.blueGrey;
                      detailscolor = Colors.blueGrey;
                      prixcolor = Colors.blueGrey;
                    });
                  },
                  onTap: (){
                    setState(() {
                     nomcolor = Colors.blueGrey;
                      detailscolor = Colors.blueGrey;
                      prixcolor = Colors.blueGrey;
                    });
                  },          keyboardType: TextInputType.number,
                                  controller:_prix,
                                 decoration: InputDecoration(
                                   border: InputBorder.none,
                                   hintText: "Entrer prix de produit",
                                   hintStyle: TextStyle(color: prixcolor,fontSize: MediaQuery.of(context).size.width*0.04),
                                 ),
                       ),
                         ),),),
                            Flexible(child: SizedBox(width:15)),
                            Flexible(
                              flex: 2,
                             child:Text("DZD",style: TextStyle(color: Colors.grey.shade400,fontSize:  ScreenUtil().setSp(40)),),
                       )
                         ],
                       ),
                       /////////////////////////////////////drop down 
                      Row(
                        children: <Widget>[
                           Container(
                             height: ScreenUtil().setHeight(120),
                             width: ScreenUtil().setWidth(400),
                             decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(12),
                           color: Colors.grey.shade200,
                         ),
                         padding:  EdgeInsets.only(top: 8,bottom: 8,right: 10),
                         margin: EdgeInsets.only(bottom: 10,top: 10,),
                         child:   DropdownButton<Item>(
            hint:  Text("  Select ....",style: TextStyle(color: Colors.blueGrey,fontSize: MediaQuery.of(context).size.width*0.04,fontWeight: FontWeight.w400),),
           icon: Icon(Icons.arrow_drop_down,size: MediaQuery.of(context).size.width*0.09,),
            value: selectedUser,
            underline: Container(color: Colors.white,),
            onChanged: (Item Value) {
              setState(() {
                selectedUser = Value;
              });
            },
            items: users.map((Item user) {
              return  DropdownMenuItem<Item>(
              
                value: user,
                child:Text(
                      "  "+user.name,
                      style:  TextStyle(color: Colors.blueGrey,fontSize: MediaQuery.of(context).size.width*0.04),
                    ),
              );
            }).toList(),
          ),
                       ),
                       Container(width: 20,)
                        ],
                      ),
                       Container(
                           height: ScreenUtil().setHeight(280),
                           padding: EdgeInsets.all(8),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(20),
                           color: Colors.grey.shade200,
                         ),
                         margin: EdgeInsets.only(bottom: 10,top: 10),
                         child: TextField(
                           style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                           onChanged: (_nom){
                    setState(() {
                      nomcolor = Colors.blueGrey;
                      detailscolor = Colors.blueGrey;
                      prixcolor = Colors.blueGrey;
                    });
                  },
                  onTap: (){
                    setState(() {
                     nomcolor = Colors.blueGrey;
                      detailscolor = Colors.blueGrey;
                      prixcolor = Colors.blueGrey;
                    });
                  },
                         controller:_details,
                           keyboardType: TextInputType.multiline,
                           maxLines: null,
                         decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(8.0, 0.8, 00.0, 12.0),
                           border: InputBorder.none,
                           hintText: "Entrer les détailles ...",
                           hintStyle: TextStyle(color: detailscolor,fontSize:  MediaQuery.of(context).size.width*0.04),
                         ),
                       )),
                                          ],
                   ),
                   decoration: BoxDecoration(
                      color:Colors.white,
                     borderRadius: BorderRadius.only(
                       topRight: Radius.circular(22),
                       topLeft: Radius.circular(22)
                     ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 0,
                          blurRadius: 0,
                        ),
                      ],
                   ),
                  
                 ),
              ),
               Positioned(
                top:ScreenUtil().setHeight(530),
                left: MediaQuery.of(context).size.width-ScreenUtil().setWidth(160),
                child: GestureDetector(
                  onTap: (){
                    getImage();
                  },
                                  child: Container(
                    height: ScreenUtil().setHeight(100),
                    width: ScreenUtil().setWidth(95),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink.shade500,
                    ),
                    child:Icon(Icons.camera_alt,color: Colors.white,size: ScreenUtil().setSp(48),),
                  ),
                ),
              ),
               Positioned(
                 top: ScreenUtil().setHeight(50),
                 left: ScreenUtil().setSp(50),
                 child: GestureDetector(
                   onTap: (){
                     Navigator.pop(context);
                   },
                   child: Container(
                     height: ScreenUtil().setWidth(80),
                     width: ScreenUtil().setWidth(80),
                     decoration: BoxDecoration(
                        color:Colors.white,
                       borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 3,
                            blurRadius: 4,
                          ),
                        ],
                     ),
                     child: Icon(Icons.arrow_back_ios,color: Colors.pink.shade600,size: ScreenUtil().setSp(40),),
                   ),
                 ),
              ),
              Positioned(
                top: ScreenUtil().setHeight(1480),
                left: 70,
                right: 70,
                child: GestureDetector(
                  onTap: (){
                    
                    if(_image != null && _nom.text.toString().trim()!=""
                    && _details.text.toString().trim()!="" 
                    && _prix.text.toString().trim()!=""
                    && !a
                    ){
                      createinterstialAd()..load()..show();
                      uploadPic(context);
                       setState(() {
                         a == true;
                       });
                    }
                  setState(() {
                  if(_nom.text.toString().trim()!="" || _nom.text.toString().trim()!=null )nomcolor = Colors.red;
                  if(_prix.text.toString().trim()!="" || _prix.text.toString().trim()!=null)prixcolor = Colors.red;
                  if(_details.text.toString().trim()!="" || _details.text.toString().trim()!=null)detailscolor = Colors.red;
                  });

                  },
                                  child: Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(50),right: ScreenUtil().setWidth(150),top:ScreenUtil().setHeight(20),bottom: ScreenUtil().setHeight(20)),
                    decoration: BoxDecoration(
                     gradient: LinearGradient(
                       colors:[Colors.pink.shade500,Colors.purple.shade500,]),
                       borderRadius: BorderRadius.circular(12),
                       
                    ),
                    child:Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: Container(),flex: 4,),
                          Expanded(
                            flex:25,
                            child: Text(" Ajouter",style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(52),
                        fontWeight: FontWeight.w500
                      ),),
                          ),
                     // SizedBox(width:ScreenUtil().setWidth(120)),
                        Expanded(child: Icon(Icons.shopping_cart,color: Colors.white,size: ScreenUtil().setSp(48),))
                        ],
                      ),
                    ),
                  ),
                ),
                )
          
              
            ],
          ),
               )
            ],
          ),
        ),
      ),
    );
  }
}

class Photo extends StatelessWidget {
  File images;
  Photo({this.images});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
          body: Center(
            child: Container(
                     color: Colors.white,
                    child: Hero(tag: "hero",
                     child:PhotoView(                      
                      imageProvider: FileImage(images,) ,         
    ), ),
      ),
          ),
    );
  }
}

class flare extends StatefulWidget {

  @override
  _flareState createState() => _flareState();
}

class _flareState extends State<flare> {
  bool _showAnimation = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        _showAnimation = true;
      });
    });
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _showAnimation = false;
      });
    });
    super.initState();
  }

   
  @override
  Widget build(BuildContext context) {
    if(_showAnimation){
       return  Scaffold(
           backgroundColor: Colors.white,
          
          body: Center(child: FlareActor("images/Success Check.flr", alignment:Alignment.center, 
          fit:BoxFit.contain,
                    animation: 'Untitled',
          snapToEnd: false,

      ),

      ),
    );
    }
    Navigator.of(context).maybePop();
   return Container(color: Colors.white,);
  }}

