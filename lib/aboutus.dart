import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "About MedLoc",
      home: AboutUs(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent),
    );
  }
}

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.lightBlue,
        title: Text('About Us', style: TextStyle(fontSize: 24.0),),
      ),
      body: Container(
        width: 500.0,
        height: 1000.0,
          color: Colors.white,
          child: SingleChildScrollView(
            child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.0,),
              //Text('About MedLoc', style: TextStyle(fontSize: 30.0, letterSpacing: 0.3, color: Colors.lightBlue, fontWeight: FontWeight.bold))
              Image.asset('images/s1.jpg'),

              Container(
                width: 370.0,
                child: Text('\n India’s Leading Digital Consumer '
                    '\n            Healthcare Platform\n',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,
                        letterSpacing: 0.3, color: Colors.lightBlue,)),
              ),
              Container(
                width: 300.0,
              child: Image.asset('images/a3.jpg',),
              ),
              SizedBox(height: 25.0,),
              Container(
                width: 310.0,
                child: Text('Order medicines and health \nproducts online and get it delivered \nat home from licensed pharmacies',
              style: TextStyle(fontSize: 18.5, letterSpacing: 0.3, fontWeight: FontWeight.bold, height: 1.4), textAlign: TextAlign.center, ),
              ),
              SizedBox(height: 20.0,),
              Container(
                width: 340.0,
              child: Text('MedLoc brings to you an online platform, \ntrying to make healthcare a hassle-free experience for you. '
                  'Get your allopathic, ayurvedic, homeopathic medicines, \nvitamins & nutrition supplements and other health-'
                  'related products \ndelivered at home. \n', style: TextStyle(fontSize: 18.0, letterSpacing: 0.3, height: 1.3),
                textAlign: TextAlign.center,),)
            ],
          ))
    ),
    );
  }
}