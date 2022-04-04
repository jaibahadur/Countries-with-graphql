import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static navigate(BuildContext context, {required Widget child}) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => Scaffold(body: child)));
  }
}
