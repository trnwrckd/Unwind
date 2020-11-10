import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapy_zone/models/user.dart';
import 'package:therapy_zone/pages/wrapper.dart';
import 'package:therapy_zone/services/auth.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(Therapy());

class Therapy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
        ),
        theme: ThemeData(primaryColor: Colors.white),
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
