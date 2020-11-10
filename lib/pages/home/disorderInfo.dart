import 'package:therapy_zone/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DisorderInfo extends StatefulWidget {
  final String name;
  final String url;
  DisorderInfo({this.name, this.url});
  @override
  _DisorderInfoState createState() => _DisorderInfoState();
}

class _DisorderInfoState extends State<DisorderInfo> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(51, 129, 239,0.8),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 55, 0),
          child: Text(
            isLoading ? 'Please wait..' : widget.name,
            style: TextStyle(
              color: Color.fromRGBO(252, 195, 163, 1),
            ),
          ),
        )),
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            initialUrl: widget.url,
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
