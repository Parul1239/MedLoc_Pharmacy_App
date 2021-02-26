import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medloc/home.dart';
import 'auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_medloc/login.dart';
import 'package:flutter_medloc/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login ",
      home: loginPage(),
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.blue,
          accentColor: Colors.blueAccent),
    );
  }
}

class loginPage extends StatefulWidget {
  loginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _loginPageState createState() => _loginPageState();
}

enum FormType{
  login,
  register,
  reset
}
class _loginPageState extends State<loginPage> {
  final double _minimumPadding = 8.0;
  final db = Firestore.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final firestoreInstance = Firestore.instance;

  var textControllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
    "name": TextEditingController()
  };
  var email;
  var name;
  var password;
  String _warning;
  var autoValidate = false;
  var isNewUser = false;
  FormType _formType = FormType.login;

  var hintText = "Email";
  var hintText2 = "Name";
  String _email, _password;
  var hintText1 = "Password";
  bool _autoValidate = false;
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  bool validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void _onPressed() async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    firestoreInstance.collection("users").document(firebaseUser.uid).setData(
        {
          "name" : name,
          "email" : _email,
          "password" : _password,
        }).then((_){
      print("success!");
    });
  }


  void validateAndSubmit() async{
    if(validateAndSave()){
      try {
        if(_formType == FormType.login) {
          String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
          await db.collection("logged-in-Users").add(
              {
                'name': name,
                'email': _email,
                'password': _password,
              }
          );
          widget.onSignedIn();
        }
        else if(_formType == FormType.reset){
          await widget.auth.sendPasswordResetEmail(_email);
          print("Password Reset Mail sent");
          _warning = "A password reset link has been sent to $_email";
          setState(() {
            _formType == FormType.login;
          });
        }
        else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered in: $userId');
          _onPressed();
          widget.onSignedIn();
        }
        // widget.onSignedIn();
      }
      catch(e){
        print('Error: $e');
        setState(() {
          _warning = e.message;
        });
      }
    }
  }

  void moveToRegister(){
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin(){
    _formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login Page',
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
              autovalidate: _autoValidate,
              child: Column(
                  children: <Widget>[
                    showAlert(),
                    Padding(
                      padding: EdgeInsets.all(_minimumPadding * 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: buildInputs() + buildSubmitButtons(),

                      ),
                    ),
                  ]),
            ))
    );
  }

  Widget showAlert() {
    if(_warning!= null) {
      return Container(
        color:  Colors.yellowAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 8.0)),
            Icon(Icons.error_outline),
            Expanded(child: Text(_warning, maxLines: 3,),),
            Padding(
                padding: const EdgeInsets.only(left: 8.0)),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: (){
                setState(() {
                  _warning = null;
                });
              },)
          ],
        ),
      );
    }
    return SizedBox(height: 0,);
  }
  List<Widget> buildInputs() {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;

    if (_formType == FormType.login) {
      return [
        getImageAsset(),
        Text(
          "LOGIN",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 18.0,
        ),
        Padding(
            padding: EdgeInsets.only(
                top: _minimumPadding, bottom: _minimumPadding),
            child: TextFormField(
              controller: textControllers["email"],
              keyboardType: TextInputType.text,
              style: textStyle,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter Email-Id';
                }
              },
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: hintText,
                labelStyle: textStyle,
                errorStyle: TextStyle(
                    color: Colors.red, fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: hintText == "Email"
                    ? Icon(Icons.email)
                    : Icon(Icons.lock),
              ),
              onSaved: (input) => _email = input,
              autovalidate: _autoValidate,
            )),
        Padding(
            padding: EdgeInsets.only(
                top: _minimumPadding, bottom: _minimumPadding),
            child: TextFormField(
              controller: textControllers["password"],
              keyboardType: TextInputType.text,
              style: textStyle,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter Password';
                }
                else if (input.length < 6) {
                  return 'The password has to be at least 6 characters long";';
                }
              },
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: hintText1,
                labelStyle: textStyle,
                errorStyle: TextStyle(
                    color: Colors.red, fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: hintText1 == "Password"
                    ? Icon(Icons.lock)
                    : Icon(Icons.lock_open),
                suffixIcon: hintText1 == "Password"
                    ? IconButton(
                  onPressed: _toggleVisibility,
                  icon: _isHidden
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                )
                    : null,
              ),
              onSaved: (input) => _password = input,
              obscureText: hintText1 == "Password"
                  ? _isHidden
                  : false,
            )),
        Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: 172.0,
              ),
              FlatButton(
                padding: EdgeInsets.all(10.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  setState(() {
                    _formType = FormType.reset;
                  });
                },
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20.0),
                ),
              )]
        ),
        Container(
          height: 10.0,
        ),
      ];
    }else if(_formType == FormType.reset){
      return[
        getImageAsset(),
        SizedBox(
          height: 15.0,
        ),
        Text(
          "Reset Password",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
            padding: EdgeInsets.only(
                top: _minimumPadding, bottom: _minimumPadding),
            child: TextFormField(
              controller: textControllers["email"],
              keyboardType: TextInputType.text,
              style: textStyle,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter Email-Id';
                }
              },
              decoration: InputDecoration(
                labelText: 'Email',
                //hintText: 'Enter Email-Id eg. abc@gmail.com',
                hintText: hintText,
                labelStyle: textStyle,
                errorStyle: TextStyle(
                    color: Colors.red, fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: hintText == "Email"
                    ?   Icon(Icons.email)
                    : Icon(Icons.lock),
              ),
              onSaved: (input) => _email = input,
              autovalidate: _autoValidate,
            )),
        SizedBox(
          height: 20.0,
        ),
      ];
    }else{
      return [
        getImageAsset(),
        Text(
          "Register",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 18.0,
        ),
        Padding(
            padding: EdgeInsets.only(
                top: _minimumPadding, bottom: _minimumPadding),
            child: TextFormField(
              controller: textControllers["name"],
              keyboardType: TextInputType.text,
              style: textStyle,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter Your Name';
                }
              },
              decoration: InputDecoration(
                labelText: 'Name',
                //hintText: 'Enter Email-Id eg. abc@gmail.com',
                hintText: hintText,
                labelStyle: textStyle,
                errorStyle: TextStyle(
                    color: Colors.red, fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: hintText == "Name"
                    ?   Icon(Icons.person)
                    : Icon(Icons.person),
              ),
              onSaved: (input) => name = input,
              autovalidate: _autoValidate,
            )),
        Padding(
            padding: EdgeInsets.only(
                top: _minimumPadding, bottom: _minimumPadding),
            child: TextFormField(
              controller: textControllers["email"],
              keyboardType: TextInputType.text,
              style: textStyle,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter Email-Id';
                }
              },
              decoration: InputDecoration(
                labelText: 'Email',
                //hintText: 'Enter Email-Id eg. abc@gmail.com',
                hintText: hintText,
                labelStyle: textStyle,
                errorStyle: TextStyle(
                    color: Colors.red, fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: hintText == "Email"
                    ?   Icon(Icons.email)
                    : Icon(Icons.lock),
              ),
              onSaved: (input) => _email = input,
              autovalidate: _autoValidate,
            )),
        Padding(
            padding: EdgeInsets.only(
                top: _minimumPadding, bottom: _minimumPadding),
            child: TextFormField(
              controller: textControllers["password"],
              keyboardType: TextInputType.text,
              style: textStyle,
              validator: (input) {
                if (input.isEmpty) {
                  return 'Please enter Password';
                }
                else if (input.length < 6) {
                  return 'The password has to be at least 6 characters long";';
                }
              },
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: hintText1,
                labelStyle: textStyle,
                errorStyle: TextStyle(
                    color: Colors.red, fontSize: 14.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                prefixIcon: hintText1 == "Password"
                    ? Icon(Icons.lock)
                    : Icon(Icons.lock_open),
                suffixIcon: hintText1 == "Password"
                    ? IconButton(
                  onPressed: _toggleVisibility,
                  icon: _isHidden
                      ? Icon(Icons.visibility_off)
                      : Icon(Icons.visibility),
                )
                    : null,
              ),
              onSaved: (input) => _password = input,
              obscureText: hintText1 == "Password"
                  ? _isHidden
                  : false,
            )),
        SizedBox(
          height: 30.0,
        )
      ];

    }
  }

  List<Widget> buildSubmitButtons(){
    //bool _showforgotpassword = false;
    if(_formType == FormType.login) {
      return [
        new SizedBox(
            height: 50.0,
            child: RaisedButton(
              color: Colors.red,
              textColor: Theme
                  .of(context)
                  .primaryColorLight,
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                // side: BorderSide(color: Colors.red)
              ),
              child: Center(
                heightFactor: 0.5,
                child: Text(
                  "LOGIN",
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
              ),
              onPressed:
              validateAndSubmit,
              //navigateToHomePage(context);
            )),
        Container(
            child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),

                    FlatButton(
                      child: Text("SIGN UP", style: TextStyle(
                        fontSize: 18.0, color: Theme
                          .of(context)
                          .primaryColor,),),
                      onPressed:
                      moveToRegister,
                    )
                  ]
              ),
            )
        ),
      ];
    }else if(_formType == FormType.reset){
      return[
        new SizedBox(
            height: 55.0,
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
                  "Submit",
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
              ),
              onPressed: validateAndSubmit,
            )),
        FlatButton(
          child: Text("Return To Sign In", style: TextStyle(fontSize: 20.0, color: Theme.of(context).primaryColor,),),
          onPressed: moveToLogin,
        ),
      ];
    }

    else{
      return[
        new SizedBox(
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
              onPressed: validateAndSubmit,
            )),
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
                      onPressed: moveToLogin,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ]
              )),
        ),
      ];
    }
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

Future navigateToSignUpPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => signupPage()));
}

Future navigateToHomePage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
}

