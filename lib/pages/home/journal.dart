import 'package:flutter/material.dart';
import 'package:therapy_zone/services/auth.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';
import 'package:therapy_zone/pages/home/newpost.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Journal extends StatefulWidget with NavigationStates {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardTextStyle = TextStyle(
        fontFamily: "SpaceGrotesk", fontSize: 18, color: Colors.white);
    void _showPostPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Color.fromRGBO(47, 94, 161, 1),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: NewPost(),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.withOpacity(0.9),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(51, 129, 239, 0.8),
          title: Center(
            child: Text(
              'JOURNAL',
              style: TextStyle(
                  color: Color.fromRGBO(252, 195, 163, 1),
                  letterSpacing: 2,
                  fontSize: 22,
                  fontWeight: FontWeight.w900),
            ),
          )),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .3,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage('assets/whimsical.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            // child: Text(
            //     '“Journaling is like whispering to one’s self and listening at the same time.” _Mina Murray',
            //     textAlign: TextAlign.center,
            //     style: cardTextStyle),
          ),
          Padding(
            padding: EdgeInsets.only(top: 280),
            child: Text(
                '“Journaling is like whispering to one’s self and listening at the same time.” _Mina Murray',
                textAlign: TextAlign.center,
                style: cardTextStyle),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 320.0),
            child: Container(
              child: StreamBuilder(
                  stream: getUsersPostsStreamSnapshots(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return const Text("Loading...",
                          style: TextStyle(color: Colors.white, fontSize: 20));
                    return new ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int index) =>
                            buildPostCard(
                                context, snapshot.data.documents[index]));
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[600],
        onPressed: () => _showPostPanel(),
        child: Icon(
          Icons.create_outlined,
          color: Colors.blue,
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getUsersPostsStreamSnapshots(
      BuildContext context) async* {
    final uid = await _auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('posts')
        .snapshots();
  }

  Widget buildPostCard(BuildContext context, DocumentSnapshot post) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        color: Color.fromRGBO(99, 43, 108, .5),
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Color.fromRGBO(99, 43, 108, 0),
            child: Text(
              post['mood'],
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          title: Text(
            post['title'],
            style: TextStyle(
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          subtitle: Text(
            post['desc'],
            style: TextStyle(fontSize: 17.0, color: Colors.white54),
          ),
          trailing: Text(
            '${DateFormat.yMd().format(post['date'].toDate()).toString()}\n${DateFormat.jm().format(post['date'].toDate()).toString()}',
            style: TextStyle(color: Colors.white38),
          ),
        ),
      ),
    );
  }
}
