import 'package:flutter/material.dart';
import 'package:therapy_zone/pages/bloc.navigation_bloc/navigation_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class Doctor extends StatefulWidget with NavigationStates {
  @override
  _DoctorState createState() => _DoctorState();
}

class _DoctorState extends State<Doctor> {
  var name = [
    "Dr. Hanif Seddiqui",
    "Dr. Osiur Rahman",
    "Dr. Anwarul Azim",
    "Dr. Fairooz Azim",
    "Dr. Manzur Kabir",
    "Dr. Ishmamur Rahman",
    "Dr. Tajbiul Hossain"
  ];
  var info = [
    "Random Hospital 1",
    "Random Hospital 2",
    "Random Hospital 3",
    "Random Hospital 4",
    "Random Hospital 5",
    "Random Hospital 6",
    "Random Hospital 7"
  ];
  var contact = [
    "01975937956",
    "01875937956",
    "01775937956",
    "01575937956",
    "01675937956",
    "01575937956",
    "01675937956"
  ];
  var email = [
    "hanif@cu.ac.bd",
    "osi@cu.ac.bd",
    "azim@cu.ac.bd",
    "fairoozazim97@gmail.com",
    "trnwrckd@gmail.com",
    "ayoncsecu17@gmail.com",
    "tbh.nishat@gmail.com"
  ];
  var img = [
    "assets/male.png",
    "assets/male.png",
    "assets/male.png",
    "assets/fem.png",
    "assets/male2.png",
    "assets/male2.png",
    "assets/male2.png"
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(51, 129, 239, 0.8),
        title: Center(
            child: Text(
          'MAKE AN APPOINMENT',
          style: TextStyle(
              color: Color.fromRGBO(252, 195, 163, 1),
              letterSpacing: 2,
              fontSize: 22,
              fontWeight: FontWeight.w900),
        )),
      ),
      body: Container(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        child: ListView.builder(
            itemCount: name.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialogFunc(context, img[index], name[index], info[index],
                      contact[index], email[index]);
                },
                child: Card(
                    color: Color.fromRGBO(47, 94, 161, 0.7),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
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
                                    info[index],
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

showDialogFunc(context, img, name, info, mobile, email) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromRGBO(47, 94, 161, 0.7),
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
                  SizedBox(height: 10.0),
                  Text(
                    info,
                    style: TextStyle(fontSize: 15.0, color: Colors.white60),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
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
