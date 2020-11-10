import 'package:flutter/material.dart';
import 'package:therapy_zone/pages/authenticate/login.dart';
import 'package:therapy_zone/services/auth.dart';
import 'package:therapy_zone/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  bool verify = false;
  String email = '', password = '', name = '', mobile = '';

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ALERT'),
            content: Text(errormessage),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    if (verify) return Login();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Scaffold(
            body: verify
                ? Login()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: size.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/grad.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  5.0, 130.0, 5.0, 0.0),
                              child: RichText(
                                  text: TextSpan(
                                      text: 'Welcome to ',
                                      style: TextStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.0),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'Self Help',
                                        style: TextStyle(
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                            color: Colors.lightBlue[900]))
                                  ])),
                            ),
                            SizedBox(height: 15.0),
                            Text(
                              'Find Your Mental Peace',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white,
                                  letterSpacing: 2.0),
                            ),
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    SizedBox(height: 30.0),
                                    TextFormField(
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                        validator: (val) =>
                                            val.isEmpty ? 'Enter Name' : null,
                                        decoration: InputDecoration(
                                            labelText: 'Name',
                                            labelStyle: new TextStyle(
                                                color: Colors.white60),
                                            prefixIcon: Icon(Icons.person,
                                                color: Colors.white60),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white60),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white60),
                                            ),
                                            errorStyle: TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 1.5)),
                                        onChanged: (val) {
                                          setState(() => name = val);
                                        }),
                                    SizedBox(height: 10.0),
                                    TextFormField(
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                        validator: (val) =>
                                            val.isEmpty ? 'Enter Email' : null,
                                        decoration: InputDecoration(
                                            labelText: 'Email',
                                            labelStyle: new TextStyle(
                                                color: Colors.white60),
                                            prefixIcon: Icon(Icons.email,
                                                color: Colors.white60),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white60),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white60),
                                            ),
                                            errorStyle: TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 1.5)),
                                        onChanged: (val) {
                                          setState(() => email = val);
                                        }),
                                    SizedBox(height: 10.0),
                                    TextFormField(
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0),
                                        validator: (val) => val.length < 6
                                            ? 'Enter Minimum 6 Characters'
                                            : null,
                                        decoration: InputDecoration(
                                            labelText: 'Password',
                                            labelStyle: new TextStyle(
                                                color: Colors.white60),
                                            prefixIcon: Icon(Icons.lock,
                                                color: Colors.white60),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white60),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white60),
                                            ),
                                            errorStyle: TextStyle(
                                                fontSize: 18,
                                                letterSpacing: 1.5)),
                                        obscureText: true,
                                        onChanged: (val) {
                                          setState(() => password = val);
                                        }),
                                    SizedBox(height: 20.0),
                                    RaisedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          final form = _formKey.currentState;
                                          form.save();
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  email, password, name);
                                          if (result is String)
                                            showError(result);
                                          setState(() {
                                            loading = false;
                                            verify = true;
                                          });
                                        }
                                      },
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 70),
                                      child: Text(
                                        'Create Profile',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 2),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      color: Colors.white30,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15.0),
                            GestureDetector(
                                onTap: widget.toggleView,
                                child: Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }
}
