import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_medloc/components/horizontal_listview.dart';
import 'package:flutter_medloc/details.dart';
import 'package:flutter_medloc/details1.dart';
import 'package:flutter_medloc/details2.dart';

class PdtItem extends StatelessWidget{
  static const routeName = "/details";
  final String med_image;
  final String med_name;
  final double med_price;
  final String old_price;
  final String ratings;
  final String reviews;
  final String brand;
  final String med_image1;
  final String desc;
  final String marketer;

  PdtItem({
    this.med_image,
    this.med_name,
    this.med_price,
    this.old_price,
    this.ratings,
    this.reviews,
    this.brand,
    this.med_image1,
    this.desc,
    this.marketer
});

  @override
  Widget build(BuildContext context) {
    final pdt = Provider.of<Product>(context);
    return Card(
        margin: EdgeInsets.all(8.0),
        elevation: 2.0,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(DetailPage.routeName, arguments: pdt.id);
          },
          child: GridTile(
              child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    Image.asset(
                      med_image,
                      width: 170.0,
                      height: 135.0,
                    ),
                    SizedBox(height: 5.0,),
                    Expanded(
                        child: Container(
                          child: new Text(med_name, style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,),
                        )),
                    SizedBox(height: 9.0,),

                  ])
          ),
        ));
  }
}

class GadgetItem extends StatelessWidget{
  static const routeName = "/details1";
  final String gadget_image;
  final String gadget_name;
  final double gadget_price;
  final String old_price;
  final String ratings;
  final String reviews;
  final String brand;
  final String gadget_image1;
  final String desc;
  final String marketer;

  GadgetItem({
    this.gadget_image,
    this.gadget_name,
    this.gadget_price,
    this.old_price,
    this.ratings,
    this.reviews,
    this.brand,
    this.gadget_image1,
    this.desc,
    this.marketer
  });

  @override
  Widget build(BuildContext context) {
    final gdt = Provider.of<Gadget>(context);
    return Card(
        margin: EdgeInsets.all(8.0),
        elevation: 2.0,
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(DetailPage1.routeName, arguments: gdt.id);
          },
          child: GridTile(
              child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0,),
                    Image.asset(
                      gadget_image,
                      width: 170.0,
                      height: 135.0,
                    ),
                    SizedBox(height: 5.0,),
                    Expanded(
                        child: Container(
                          child: new Text(gadget_name, style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,),
                        )),
                    SizedBox(height: 9.0,),

                  ])
          ),
        ));
  }
}

class MedItem extends StatelessWidget {
  static const routeName = "/details2";
  final String medi_image;
  final String medi_name;
  final double medi_price;
  final String old_price;
  final String ratings;
  final String reviews;
  final String brand;
  final String medi_image1;
  final String desc;
  final String marketer;

  MedItem({
    this.medi_image,
    this.medi_name,
    this.medi_price,
    this.old_price,
    this.ratings,
    this.reviews,
    this.brand,
    this.medi_image1,
    this.desc,
    this.marketer
  });
  @override
  Widget build(BuildContext context) {
    final medt = Provider.of<Medicine>(context);
    return Padding(padding: const EdgeInsets.only(left: 2.0, right: 2.0, top: 0.0),
        child: InkWell(onTap: () async {
          Navigator.of(context)
              .pushNamed(DetailPage2.routeName, arguments: medt.id);
        },
          child: Container(
            width: 150.0,
            height: 240.0,
            decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [BoxShadow(color: Colors.grey,
              blurRadius: 5.0,)] , color: Color.fromRGBO(255, 255, 255, 1.0), borderRadius: BorderRadius.circular(5.0) ),
            margin: EdgeInsets.only(left: 12.0, right: 0.0, bottom: 15.0, top: 12.0),
            child: ListTile(
              title: Image(image: AssetImage(medi_image),
                width: 150.0,
                height: 120.0,),
              subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(medi_name, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,),
              ),
            ),
          ),
        ));

  }
}