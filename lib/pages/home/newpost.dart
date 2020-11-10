import 'package:flutter/material.dart';
import 'package:therapy_zone/services/auth.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _desc;
  DateTime _date;
  double _currentSliderValue = 60;

  String emoji = "\u{1F610}";
  void setEmoji(double value) {
    if (value == 0) {
      emoji = "\u{1F616}";
    }
    if (value == 20) {
      emoji = "\u{1F62A}";
    }
    if (value == 40) {
      emoji = "\u{1F641}";
    }
    if (value == 60) {
      emoji = "\u{1F610}";
    }
    if (value == 80) {
      emoji = "\u{1F600}";
    }
    if (value == 100) {
      emoji = "\u{1F604}";
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            'Share With Us',
            style: TextStyle(
                color: Color.fromRGBO(252, 195, 163, 1),
                fontSize: 22.0,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 10.0),
          TextFormField(
              style: TextStyle(color: Colors.white60, fontSize: 20.0),
              decoration: InputDecoration(
                labelText: 'Your mood right now',
                labelStyle:
                    new TextStyle(color: Colors.white60, fontSize: 15.0),
                prefixIcon: Icon(Icons.mood, color: Colors.white60),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60),
                ),
              ),
              validator: (val) =>
                  val.isEmpty ? 'Please enter current mood' : null,
              onChanged: (val) => _title = val),
          SizedBox(height: 5.0),
          TextFormField(
              style: TextStyle(color: Colors.white60, fontSize: 20.0),
              decoration: InputDecoration(
                labelText: 'Tell us how are you feeling',
                labelStyle:
                    new TextStyle(color: Colors.white60, fontSize: 15.0),
                prefixIcon: Icon(Icons.description, color: Colors.white60),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white60),
                ),
              ),
              validator: (val) =>
                  val.isEmpty ? 'Please tell us your feeling?' : null,
              onChanged: (val) => _desc = val),
          SizedBox(height: 5.0),
          Slider(
            //active and inactive color ??
            value: _currentSliderValue,
            min: 0,
            max: 100,
            divisions: 5,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value ?? _currentSliderValue;
                setEmoji(_currentSliderValue);
                _date = DateTime.now();
              });
            },
          ),
          SizedBox(height: 10.0),
          Text(emoji, style: TextStyle(fontSize: 30)),
          SizedBox(height: 15.0),
          FloatingActionButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _date = DateTime.now();
                _auth.postUpdate(_title, _desc, emoji, _date);
                _auth.updateCounter(emoji);
                Navigator.of(context).pop();
              }
            },
            backgroundColor: Color.fromRGBO(240, 159, 156, 1),
            child: Icon(
              Icons.send_outlined,
              color: Colors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
