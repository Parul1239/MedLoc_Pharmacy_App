import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_medloc/components/cart.dart';

class CartPdt extends StatelessWidget{
  final String id;
  final String productId;
  final String image;
  final double price;
  final int quantity;
  final String name;

  CartPdt(this.id,this.productId,this.price,this.quantity,this.image,this.name);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        child: Container(
          height: 115.0,
          decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [BoxShadow(color: Colors.grey,
            blurRadius: 5.0,)] , borderRadius: BorderRadius.circular(7.0), color: Color.fromRGBO(255, 255, 255, 1.0) ),
          margin: EdgeInsets.only(top: 2.0, left: 5.0, right: 5.0),
          child: ListTile(
            title: Row(
              children: <Widget>[
                Container(
                    child: Image(image: AssetImage(image),
                  width: 100.0,
                  height: 100.0,
                  alignment: Alignment.topLeft,
            )),
          Padding(padding: EdgeInsets.only(left: 5.0, top: 10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Row(
                      children: <Widget>[
                      Text(name, style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                    ],
                  )),
                  SizedBox(height: 10.0,),
                  Text(' Total: \$${(price * quantity)}', style: TextStyle(fontSize: 18.0),),
           ]),
          ),
            ]),
            trailing: Text('$quantity x', style: TextStyle(fontSize: 18.0),),
        )),
      ),
    );
  }

}