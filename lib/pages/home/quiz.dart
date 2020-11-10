import 'package:therapy_zone/pages/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:therapy_zone/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Quiz extends StatefulWidget with NavigationStates {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(51, 129, 239, 0.8),
        title: Center(
            child: Text(
          isLoading ? "Please Wait..." : 'TAKE A QUIZ',
          style: TextStyle(
              color: Color.fromRGBO(252, 195, 163, 1),
              letterSpacing: 2,
              fontSize: 22,
              fontWeight: FontWeight.w900),
        )),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: 'https://www.16personalities.com/free-personality-test',
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Loading() : Stack(),
        ],
      ),
    );
  }
}
