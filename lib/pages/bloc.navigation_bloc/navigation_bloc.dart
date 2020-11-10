import 'package:bloc/bloc.dart';
import 'package:therapy_zone/pages/home/About.dart';
import 'package:therapy_zone/pages/home/home_page.dart';
import '../home/journal.dart';
import '../home/learn.dart';
import '../home/quiz.dart';
import '../home/chart.dart';
import '../home/doctor.dart';

enum NavigationEvents {
  HomeClickedEvent,
  JournalClickedEvent,
  LearnClickedEvent,
  QuizClickedEvent,
  ChartClickedEvent,
  DoctorListClickedEvent,
  AboutClickedEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => Home();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomeClickedEvent:
        yield Home();
        break;
      case NavigationEvents.JournalClickedEvent:
        yield Journal();
        break;
      case NavigationEvents.LearnClickedEvent:
        yield Learn();
        break;
      case NavigationEvents.QuizClickedEvent:
        yield Quiz();
        break;
      case NavigationEvents.ChartClickedEvent:
        yield Chart();
        break;
      case NavigationEvents.DoctorListClickedEvent:
        yield Doctor();
        break;
      case NavigationEvents.AboutClickedEvent:
        yield About();
        break;
    }
  }
}
