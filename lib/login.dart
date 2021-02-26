import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medloc/db/users.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "User Registration",
      home: signupPage(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent),
    );
  }
}

class signupPage extends StatefulWidget {
  @override
  _signupPageState createState() => _signupPageState();
}

class _signupPageState extends State<signupPage> {

  var hintText = "Email";
  var hintText1 = "Password";
  var hintText2 = "Full Name";
  final double _minimumPadding = 8.0;
  UserServices _userServices = UserServices();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String gender;
  String groupValue = 'Male';
  bool loading = false;
  bool _isHidden = true;
  var _radioValue1;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Register',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Padding(padding: EdgeInsets.all(_minimumPadding * 2),
              child: Column(
                  children: <Widget>[
                    getImageAsset(),
                    Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(
                      height: 10.0,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                      child: Row(
                          children: <Widget>[
                            Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: textStyle,
                                  controller: _nameTextController,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return "Please enter Your Full Name";
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Full Name',
                                    hintText: hintText2,
                                    labelStyle: textStyle,
                                    errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0)),
                                    prefixIcon: hintText2 == "Full Name" ? Icon(Icons.person_outline) : Icon(Icons.person),
                                  ),
                                )),

                            SizedBox(
                              width: 10.0,
                            ),
                          ]),
                    ),

                    Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Row(
                          children: <Widget>[
                            Container(width: 9.0),
                            Icon(Icons.wc, color: Colors.black54,),
                            Container(width: 10.0,),
                            Text(
                              "Gender",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                            Container(width: _minimumPadding * 2),
                            new Radio(
                              value: 'Male',
                              groupValue: groupValue,
                              onChanged: (e) => valueChanged(e),
                            ),
                            new Text(
                              'Male',
                              style: new TextStyle(fontSize: 20.0, color: Colors.black),
                            ),

                            Container(width: _minimumPadding * 2),
                            new Radio(
                              value: 'Female',
                              groupValue: groupValue,
                              onChanged: (e) => valueChanged(e),
                            ),
                            new Text(
                              'Female',
                              style: new TextStyle(fontSize: 20.0,),
                            ),
                          ],
                        )),


                    Padding(
                        padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: textStyle,
                          controller: _emailTextController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter Your Email-Id';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: hintText,
                            labelStyle: textStyle,
                            errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            prefixIcon: hintText == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
                          ),
                        )),

                    Padding(
                        padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: textStyle,
                          controller: _passwordTextController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                            else if(value.length < 6){
                              return 'Password should be atleast 6 characters long';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: hintText1,
                            labelStyle: textStyle,
                            errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            prefixIcon: hintText1 == "Password"
                                ? Icon(Icons.lock)
                                : Icon(Icons.lock_open),
                            suffixIcon: hintText1 == "Password"
                                ? IconButton(
                              onPressed: _toggleVisibility,
                              icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                            )
                                : null,
                          ),
                          obscureText: hintText1 == "Password" ? _isHidden : false,
                        )),

                    Padding(
                        padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          style: textStyle,
                          controller: _confirmPasswordController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter Password';
                            }
                            else if(value.length < 6){
                              return 'Password should be atleast 6 characters long';
                            }
                            else if(_passwordTextController.text != value){
                              return 'The Passwords do not match';
                            }
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Confirm Password',
                            labelStyle: textStyle,
                            errorStyle: TextStyle(color: Colors.red, fontSize: 14.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0)),
                            prefixIcon: hintText1 == "Password"
                                ? Icon(Icons.lock)
                                : Icon(Icons.lock_open),
                            suffixIcon: hintText1 == "Password"
                                ? IconButton(
                              onPressed: _toggleVisibility,
                              icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                            )
                                : null,
                          ),
                          obscureText: hintText1 == "Password" ? _isHidden : false,
                        )),

                    Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Container(
                          child: Text("Use 8 or more characters with a mix of letters, numbers & symbols",
                            style: TextStyle(
                              fontSize: 15.0,
                            ),),
                        )),

                    SizedBox(height: 25.0,),
                    SizedBox(
                        height: 50.0,
                        child: RaisedButton(
                            color: Colors.red,
                            textColor: Theme.of(context).primaryColorLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                            ),
                            child: Center(
                              heightFactor: 0.5,
                              child: Text(
                                "Create Account",
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                              ),
                            ),
                            onPressed: () async{
                              // validateForm();
                            }
                        )),

                    Container(
                      height: 15.0,
                    ),
                    Container(
                      child: Center(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(fontSize: 18.0),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),

                                FlatButton(
                                  child: Text("SIGN IN", style: TextStyle(fontSize: 18.0, color: Theme.of(context).primaryColor,),),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ]
                          )),
                    ),
                  ]),
            ),
          ),
        )
    );
  }

  valueChanged(e) {
    setState(() {
      if(e == 'Male'){
        groupValue = e;
        gender = e;
      }else if(e == 'Female'){
        groupValue = e;
        gender = e;
      }
    });

  }
}

Widget getImageAsset() {
  AssetImage assetImage = AssetImage('images/user1.png');
  Image image = Image(image: assetImage, width: 125.0, height: 125.0);
  final double _minimumPadding = 5.0;
  return Container(
    child: image,
    margin: EdgeInsets.all(_minimumPadding * 5),
  );
}
