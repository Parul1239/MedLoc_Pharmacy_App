import 'package:flutter/material.dart';
import 'package:flutter_medloc/components/cart.dart';
import 'package:flutter_medloc/components/cart_item.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Pay extends StatefulWidget {

  @override
  CartScreen createState() => CartScreen();
}

class CartScreen extends State<Pay> {
  int totalAmount = 0;
  Razorpay _razorpay;
  @override
  void initState(){
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose(){
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async{
    var options = {
      'key' : 'rzp_test_OJCDcPRQysdzkk',
      'amount' : totalAmount * 100,
      'name' : 'MedLoc',
      'description' : 'Payment for Product',
      'prefill' : {'contact' : '' , 'email' : ''},
      'external' : {
        'wallets' : ['paytm']
      }
    };
    try{
      _razorpay.open(options);
    }
    catch(e){
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: "SUCCESS" + response.paymentId);
      Provider.of<Cart>(context, listen: false).clear();
  }

  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: "ERROR" + response.code.toString() + " . " + response.message);
    Provider.of<Orders>(context, listen: false).fetchorders();
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: "EXTERNAL WALLET" + response.walletName);
  }

  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
   // final order = Provider.of<ViewOrder>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('My Cart', style: TextStyle(fontSize: 24.0, color: Colors.white),),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
          child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, i) =>
                  CartPdt(
                      cart.items.values.toList()[i].id,
                      cart.items.keys.toList()[i],
                      cart.items.values.toList()[i].price,
                      cart.items.values.toList()[i].quantity,
                      cart.items.values.toList()[i].image,
                      cart.items.values.toList()[i].name,
                  ))),

          Container(
            height: 60.0,
            width: 370.0,
            decoration: BoxDecoration(shape: BoxShape.rectangle, boxShadow: [BoxShadow(color: Colors.grey,
              blurRadius: 5.0,)] , color: Color.fromRGBO(255, 255, 255, 1.0) ),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Row(
                children: <Widget>[
                  Text("  Amount To Pay: \n  \$${(cart.totalAmount)}", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),),
                    Container(
                      margin: EdgeInsets.only(left: 88.0),
                        width: 130.0,
                        height: 45.0,
                        child: RaisedButton(
                      splashColor: Colors.grey,
                      color: Colors.red,
                      textColor: Theme.of(context).primaryColorLight,
                child: Center(
                  heightFactor: 0.5,
                  child: Text("Checkout", textScaleFactor: 1.0,
                    style: TextStyle(color: Colors.white, fontSize: 21.0,),),
                ),
                onPressed: () {
                        if(cart.totalAmount != 0)
                          {
                            totalAmount = cart.totalAmount.toInt();
                            openCheckout();
                            Provider.of<Orders>(context, listen: false)
                                  .addOrder(
                                  cart.items.values.toList(),
                                  cart.totalAmount);
                          }
                        else
                          showAlertDialog(context);
                }
            )),
                ]),
          ),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Payment Alert"),
    content: Text("There is no item in the cart. \nPlease select an Item."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://medloc-6f295.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();
    try {
      final response = await http.post(url,
          body: json.encode({
            'id': DateTime.now().toString(),
            'amount': total,
            'dateTime': timeStamp.toIso8601String(),
            'products': cartProducts
                .map((cp) => {
              'id': cp.id,
              'title': cp.name,
              'quantity': cp.quantity,
              'price': cp.price
            })
                .toList(),
          }));
      _orders.insert(
          0,
          OrderItem(
              //id: json.decode(response.body)['name'],
              amount: total,
              dateTime: timeStamp,
              products: cartProducts));
      notifyListeners();
    } catch (err) {
      throw err;
    }
  }

 Future<void> fetchorders() async {
    final response = await http.get("https://medloc-6f295.firebaseio.com/orders.json?");
    print(json.decode(response.body));
  }


}

