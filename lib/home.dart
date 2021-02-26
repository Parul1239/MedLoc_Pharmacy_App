import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_medloc/components/cart_products.dart';
import 'package:flutter_medloc/components/horizontal_listview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_medloc/medicine.dart';
import 'package:flutter_medloc/profile_view.dart';
import 'package:flutter_medloc/signin.dart';
import 'aboutus.dart';
import 'auth.dart';
import 'package:flutter_medloc/components/cart.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_medloc/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget{
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  Future<String> getCurrentUserEmail() async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseUser user = await _firebaseAuth.currentUser();
      print('Hello ' + user.displayName.toString());
    print('Email ' + user.email.toString());
    final String email = user.email.toString();
    print(email);
    return email;
  }
  void _signOut() async {
    try{
      await auth.signOut();
      onSignedOut();
    }catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cart>(context);
    Widget image_corousel = new Container(
      height: 230.0,
      child: new Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('images/d1.jpg'),
          AssetImage('images/d3.jpg'),
          Image.asset('images/med19.jpg'),
          AssetImage('images/d2.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 5.0,
        indicatorBgPadding: 12.0,
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightBlue,
        title: Text('MedLoc', style: TextStyle(fontSize: 24.0),),
        actions: <Widget>[
         // IconButton(icon: Icon(Icons.search, color: Colors.white,),onPressed: (){}),
          GestureDetector(
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.shopping_cart, color: Colors.white,),
                  onPressed: (){
                    if(cart.itemCount != null)
                      Navigator.push(context, MaterialPageRoute(builder: (context) => new Pay()));
                  },
                ),
                if(cart.itemCount > 0)
                  Padding(padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        cart.itemCount.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,),
                      ),
                    ),)
              ],
            ),)
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text('Welcome', style: TextStyle(fontSize: 22.0),),
              accountEmail: FutureBuilder<String>(
                future: auth.getCurrentUserEmail(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data, style: TextStyle(fontSize: 22.0),);
                  }
                  else {
                    return Text("Loading user data...");
                  }
                }),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.lightBlue
              ),
            ),

            InkWell(
                onTap: (){
                  navigateToProfilePage(context);
                },
                child: ListTile(
                  title: Text('My Account', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.person, color: Colors.blue,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),

            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new Pay()));
                },
                child: ListTile(
                  title: Text('Shopping Cart', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.shopping_cart, color: Colors.blue,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),

            InkWell(
                onTap: _signOut,
                child: ListTile(
                  title: Text('Log Out', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.settings, color: Colors.red,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),

            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
                },
                child: ListTile(
                  title: Text('About Us', style: TextStyle(fontSize: 18.0),),
                  leading: Icon(Icons.help, color: Colors.red,),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
                )),


          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          image_corousel,
          Container(
              margin: EdgeInsets.only(left: 18.0, top: 15.0),
              width: 150.0,
              height: 30.0,
              child: Text('What are you looking For?', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))
          ),
          Row(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),

                        Container(
                            width: 175.0,
                            height: 190.0,
                            decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [BoxShadow(color: Colors.grey,
                              blurRadius: 5.0,)] , color: Color.fromRGBO(255, 255, 255, 1.0), borderRadius: BorderRadius.circular(6.0)),
                            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  getImageAsset3(),
                                  FlatButton(
                                      onPressed: (){
                                        //navigateToSearchPage(context);
                                        navigateToMedicinePage(context);
                                      },
                                      child: Text('Pharmacy', style: TextStyle(fontSize: 20.0),))
                                ])),


                      ]
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 0.0, right: 0.0),
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 10.0,),
                        Container(
                            width: 175.0,
                            height: 190.0,
                            decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [BoxShadow(color: Colors.grey,
                              blurRadius: 5.0,)] , color: Color.fromRGBO(255, 255, 255, 1.0), borderRadius: BorderRadius.circular(6.0) ),
                            margin: EdgeInsets.only(left: 0.0, right: 0.0, bottom: 15.0),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  getImageAsset1(),
                                  FlatButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => GadgetsPage()));
                                  },
                                      child: Text('HealthCare Gadgets', style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center,))
                                ])),

                      ]
                  )
              ),


            ],
          ),

          Container(
            margin: EdgeInsets.only(left: 22.0, top: 5.0),
            width: 150.0,
            height: 30.0,
            child: Text('Other Products & Gadgets', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
          ),
          //HorizontalList1(),
          OtherMed(),
        ],
      ),

    );
  }
}

Widget getImageAsset() {
  Image image = Image(image: AssetImage('images/m9.jpg'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
  );
}

Widget getImageAsset1() {
  Image image = Image(image: AssetImage('images/m8.jpg'), width: 160.0, height: 140.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
  );
}

Widget getImageAsset2() {
  Image image = Image(image: AssetImage('images/m7.webp'), width: 160.0, height: 145.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0),
  );
}

Widget getImageAsset3() {
  Image image = Image(image: AssetImage('images/d9.jpg'), width: 160.0, height: 130.0);
  return Container(
    child: image,
    margin: EdgeInsets.only(left: 5.0, top: 4.0, right: 5.0),
  );
}


Future navigateToHomePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

Future navigateToMedicinePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => MedicinePage()));
}

Future navigateToProfilePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
}

