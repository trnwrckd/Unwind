import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:therapy_zone/models/user.dart';
import 'package:therapy_zone/pages/authenticate/authenticate.dart';
import 'package:therapy_zone/pages/sidebar/sidebar_layout.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null || !user.isEmailverified) {
      return Authenticate();
    } else {
      return SideBarLayout();
    }
  }
}

// convert stacks to columns

// show error message at forget password

// add app icon

// change app name
