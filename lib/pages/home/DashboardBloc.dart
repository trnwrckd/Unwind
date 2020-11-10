import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapy_zone/pages/bloc.navigation_bloc/navigation_bloc.dart';

class DashBoardBloc extends StatelessWidget {
  final cardTextStyle = TextStyle(
      fontFamily: "IBMPlexSans",
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      color: Colors.lightBlue[800]);
  final cardTextStyleTwo = TextStyle(
      fontFamily: "SpaceGrotesk",
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 20,
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 5.0),
              crossAxisSpacing: 20,
              primary: false,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.JournalClickedEvent);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white30,
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/journal.jpg'),
                          height: 100.0,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Mood Journal',
                          style: cardTextStyleTwo,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.LearnClickedEvent);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white30,
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/learn.jpg'),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Learn',
                          style: cardTextStyleTwo,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.ChartClickedEvent);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white30,
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/stats_two.jpg'),
                          height: 80.0,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Stats',
                          style: cardTextStyleTwo,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.QuizClickedEvent);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white30,
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/test_three.png'),
                          height: 80.0,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Take a test',
                          style: cardTextStyleTwo,
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<NavigationBloc>(context)
                        .add(NavigationEvents.DoctorListClickedEvent);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white30,
                    elevation: 4.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(
                          image: AssetImage('assets/appointment_two.jpg'),
                          height: 80.0,
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Professoinal help',
                          style: cardTextStyleTwo,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
