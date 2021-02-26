import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medloc/components/cart.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter_medloc/components/cart_products.dart';
import 'components/horizontal_listview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Search Doctors, Specialists ",
      home: DetailPage(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent),
    );
  }
}

class DetailPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const routeName = "/details";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedPdt = Provider.of<Products>(context).findById(productId);
    Widget image_corousel1 = new Container(
      height: 250.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          Image.asset(loadedPdt.med_image),
          Image.asset(loadedPdt.med_image1),
        ],
        autoplay: false,
        dotSize: 5.0,
        indicatorBgPadding: 12.0,
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 0.1,
          backgroundColor: Colors.lightBlue,
          title: Text('Product Details', style: TextStyle(fontSize: 24.0),),
          actions: <Widget>[
            new IconButton(
              icon: Icon(Icons.search, color: Colors.white,),
              onPressed: (){},
            ),
            new GestureDetector(
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
        body: new ListView(
          children: <Widget>[
            SizedBox(height: 15.0,),
            new Container(
              height: 867.0,
              child: GridTile(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 10.0), alignment: Alignment.centerLeft,
                        width: 450.0,
                        child: Text(loadedPdt.med_name, style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold,),
                        textAlign: TextAlign.left,),
                      ),
                      SizedBox(height: 5.0,),
                      Text(loadedPdt.brand, style: TextStyle(fontSize: 18.0, color: Colors.grey, fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic), ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 18.0, top: 10.0),
                            width: 43.0, height: 30.0, color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(loadedPdt.ratings, style: TextStyle(color: Colors.white),),
                                Icon(Icons.star, color: Colors.white, size: 14.0,),
                          ],),
                      ),
                        Container(
                          margin: EdgeInsets.only(left: 8.0, top: 10.0) ,
                          child: Text(loadedPdt.reviews, style: TextStyle(fontSize: 18.0, color: Colors.red, fontWeight: FontWeight.bold,
                          ), ),
                        ),
                        ],),
                      SizedBox(height: 10.0,),
                      image_corousel1,
              Row(
                children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 15.0, top: 15.0),
                    child: Text('\u{20B9}${loadedPdt.med_price}', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold,),)),
                  Container(
                    margin: EdgeInsets.only(left: 135.0, top: 25.0),
                    height: 45.0,
                    width: 150.0,
                    child: RaisedButton(
                        splashColor: Colors.grey,
                        color: Colors.red,
                        textColor: Theme.of(context).primaryColorLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                        child: Center(
                          heightFactor: 0.5,
                          child: Text("Add To Cart", textScaleFactor: 1.0,
                            style: TextStyle(color: Colors.white, fontSize: 20.0,),),
                        ),
                        onPressed: () {
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              duration: Duration(seconds: 2),
                                content: Text('Item Added To Cart')));
                            cart.addItem(productId, loadedPdt.med_image, loadedPdt.med_name, loadedPdt.med_price);
                        }
                    ),
                  ),
              ],
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0, top: 0.0),
                  child: Row(children: <Widget>[
                    Text("MRP ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                      color: Colors.grey,)),
                    Text("\u{20B9}${loadedPdt.old_price}", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,
                        color: Colors.grey, decoration: TextDecoration.lineThrough),)
                  ],),
              ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, top: 15.0),
                        child: Text("Product Description", style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold,),
                          ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.0, top: 10.0),
                        width: 355.0,
                        child: Text(loadedPdt.desc, style: TextStyle(fontSize: 18.0, letterSpacing: 0.3, height: 1.3),
                          ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 10.0),
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.lightBlue), height: 10.0, width: 10.0,),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Text("  Cash on Delivery Available", style: TextStyle(fontSize: 19.0, letterSpacing: 0.3, fontWeight: FontWeight.bold),),
                          ),
                        ],),

                      Container(
                        width: 362.0,
                        height: 125.0,
                        margin: EdgeInsets.only(left: 15.0, top: 12.0),
                        decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [BoxShadow(color: Colors.grey,
                          blurRadius: 5.0,)] , color: Color.fromRGBO(255, 255, 255, 1.0) ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 8.0,),
                              Text('  Manufacturer/Marketer Address', style: TextStyle(fontSize: 20.0,
                                  letterSpacing: 0.3, fontWeight: FontWeight.bold),),
                              SizedBox(height: 8.0,),
                              Container(
                                margin: EdgeInsets.only(left: 13.0),
                                child: Text(loadedPdt.marketer, style: TextStyle(fontSize: 18.0,
                                    letterSpacing: 0.3, height: 1.3),),
                              ),

                      ])
                      ),
                    ]),
            ))
          ],
        ),
    );
  }

}

