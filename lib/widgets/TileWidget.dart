import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  const TileWidget({Key? key, this.subtitle, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        title: Text(title!),
        subtitle: Text(
          subtitle!,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }
}
