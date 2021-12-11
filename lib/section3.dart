import 'package:flutter/material.dart';

class Section3 extends StatefulWidget {
  @override
  _Section3State createState() => _Section3State();
}

class _Section3State extends State<Section3> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
        ),
        Expanded(
          flex: 3,
          child: Container(
            width: 400.0,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '🔍 Search',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: 50.0,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.download),
              label: Text('Download'),
            ),
          ),
        ),
        Expanded(flex: 2, child: Container()),
      ],
    );
  }
}
