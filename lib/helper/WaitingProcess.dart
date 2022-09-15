import 'package:easytax/helper/Laoder.dart';
import 'package:flutter/material.dart';

class Waiting {
  static void show(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: LoaderTwo(),
                )
              ],
            ));
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
