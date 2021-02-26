import 'package:flutter/material.dart';
import 'package:flutter_medloc/components/cart_products.dart';
import 'package:flutter_medloc/components/horizontal_listview.dart';
import 'package:provider/provider.dart';
import 'package:flutter_medloc/components/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Search Medicine / Health Products ",
      home: MedicinePage(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent),
    );
  }
}


class MedicinePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   final cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightBlue,
        title: Text('Products', style: TextStyle(fontSize: 24.0),),
          actions: <Widget>[
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
        body: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Medicine / Health Products',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  )),
              Column(
                children: <Widget>[
                  Container(
                    height: 600.0,
                    width: 500.0,
                    child: AllProducts(),
                  )
                ],
              ),

            ])
    );
  }
}


class GadgetsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightBlue,
        title: Text('Gadgets', style: TextStyle(fontSize: 24.0),),
        actions: <Widget>[
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
        body: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search HealthCare Gadgets',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  )),
              Column(
                children: <Widget>[
                  Container(
                    height: 600.0,
                    width: 500.0,
                    child: AllGadgets(),
                  )
                ],
              ),

            ])
    );

  }
}