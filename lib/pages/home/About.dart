import 'package:flutter/material.dart';
import 'package:therapy_zone/pages/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget with NavigationStates {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  var name = [
    "Manzur Kabir Ayon",
    "Ishmamur Rahman",
    "Fairooz Azim",
    "Tajbiul Hossain"
  ];
  var id = ["17701056", "17701063", "17701083", "17701090"];
  var mobile = [
    "+8801521316593",
    "+8801930541402",
    "+8801817602086",
    "+8801705504590"
  ];
  var email = [
    "ayoncsecu17@gmail.com",
    "trnwrckd@gmail.com",
    "fairoozazim97@gmail.com",
    "tbh.nishat@gmail.com"
  ];
  var img = [
    "assets/st1.png",
    "assets/st2.png",
    "assets/st3.png",
    "assets/st4.png"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(51, 129, 239, 0.8),
        title: Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Center(
              child: Text(
            'OUR TEAM',
            style: TextStyle(
                color: Color.fromRGBO(252, 195, 163, 1),
                letterSpacing: 2,
                fontSize: 22,
                fontWeight: FontWeight.w900),
          )),
        ),
      ),
      body: Container(
        color: Colors.lightBlueAccent.withOpacity(0.3),
        child: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialogFunc(context, img[index], name[index], id[index],
                      mobile[index], email[index]);
                },
                child: Card(
                    color: Color.fromRGBO(47, 94, 161, 0.5),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            child: Image.asset(img[index]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name[index],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  width: width,
                                  child: Text(
                                    id[index],
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }
}

void customLaunch(command) async {
  if (await canLaunch(command)) {
    await launch(command);
  } else {
    print('could not launch $command');
  }
}

showDialogFunc(context, img, name, id, mobile, email) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(47, 94, 161, 0.8),
              ),
              padding: EdgeInsets.all(15.0),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(img, width: 150, height: 150),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white60,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton.icon(
                        onPressed: () {
                          customLaunch('tel: $mobile');
                        },
                        icon: Icon(Icons.phone),
                        label: Text('Call'),
                      ),
                      RaisedButton.icon(
                        onPressed: () {
                          customLaunch(
                              'mailto:$email?subject=make%20appoinment&body=i%20want%20to%20make%20an%20appointment%20on%20dd/mm/yy%20at%20hh:mm');
                        },
                        icon: Icon(Icons.email),
                        label: Text('Email'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
