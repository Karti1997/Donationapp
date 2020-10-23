import 'package:flutter/material.dart';
import 'package:giveaway/donar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signup.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences preferences = await SharedPreferences.getInstance();
  //var email = preferences.getString('email');
  //runApp(email == null ? new MyApp() : HomePage());
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signin': (BuildContext context) => new MyHomePage(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/donor': (BuildContext context) => new Donar()
      },
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController = new TextEditingController();
  TextEditingController pwdInputController = new TextEditingController();

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  Future checkLogin() async {
    await Firebase.initializeApp();
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailInputController.text, password: pwdInputController.text)
        .then((value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', emailInputController.text);
      Navigator.of(context).pushNamed('/donor');
    }).catchError((error) {
      print('User not found');
    });
  }

  void _signIn() async {
    String username;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();
    final GoogleSignInAccount googleuser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleauth =
        await googleuser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken, idToken: googleauth.idToken);

    await Firebase.initializeApp();
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (user != null) {
      username = user.additionalUserInfo.profile.values.elementAt(0);
    } else {
      username = null;
    }
    print(username);
    Navigator.of(context).pushNamed('/donor');
    /*Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new AppListView()));*/
  }

  void showReset() {
    TextEditingController emailresetController = new TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 5,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailresetController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                        hintText: 'example@gmail.com',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.white,
                    child: MaterialButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Firebase.initializeApp();
                        FirebaseAuth.instance.sendPasswordResetEmail(
                            email: emailresetController.text);
                      },
                      padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new SafeArea(
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(15.0, 40.0, 0.0, 0.0),
                        child: Text('Give',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(16.0, 105.0, 0.0, 0.0),
                        child: Text('Away',
                            style: TextStyle(
                                fontSize: 80.0, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(210.0, 175.0, 0.0, 0.0),
                        child: Text('Small Action, BIG Change!',
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green)),
                      )
                    ],
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                    child: Form(
                        key: _loginFormKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: emailValidator,
                              controller: emailInputController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: pwdValidator,
                              controller: pwdInputController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              obscureText: true,
                            ),
                            SizedBox(height: 5.0),
                            Container(
                              alignment: Alignment(1.0, 0.0),
                              padding: EdgeInsets.only(top: 15.0, left: 20.0),
                              child: InkWell(
                                onTap: () {
                                  showReset();
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              height: 40.0,
                              child: Material(
                                borderRadius: BorderRadius.circular(20.0),
                                shadowColor: Colors.greenAccent,
                                color: Colors.green,
                                elevation: 7.0,
                                child: GestureDetector(
                                  onTap: () {
                                    print(emailInputController.text +
                                        pwdInputController.text);
                                    if (_loginFormKey.currentState.validate()) {
                                      print("valid");
                                      checkLogin();
                                    }
                                  },
                                  child: Center(
                                    child: Text(
                                      'LOGIN',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Container(
                              height: 40.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid,
                                        width: 1.0),
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: GestureDetector(
                                  onTap: () {
                                    _signIn();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                        child: ImageIcon(
                                            AssetImage('assets/g.png')),
                                      ),
                                      SizedBox(width: 10.0),
                                      Center(
                                        child: Text('Log in with Gmail',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat')),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'New to GiveAway ?',
                      style: TextStyle(fontFamily: 'Montserrat'),
                    ),
                    SizedBox(width: 5.0),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/signup');
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
