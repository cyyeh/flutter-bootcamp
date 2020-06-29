import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  List<Widget> createXylophone() {
    Expanded createXylophoneComponent({MaterialColor color, int soundNumber}) {
      return Expanded(
        child: FlatButton(
          color: color,
          onPressed: () {
            final player = AudioCache();
            player.play('note$soundNumber.wav');
          },
          child: null,
        ),
      );
    }

    return <Widget>[
      createXylophoneComponent(color: Colors.red, soundNumber: 1),
      createXylophoneComponent(color: Colors.orange, soundNumber: 2),
      createXylophoneComponent(color: Colors.yellow, soundNumber: 3),
      createXylophoneComponent(color: Colors.green, soundNumber: 4),
      createXylophoneComponent(color: Colors.blue, soundNumber: 5),
      createXylophoneComponent(color: Colors.cyan, soundNumber: 6),
      createXylophoneComponent(color: Colors.purple, soundNumber: 7),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createXylophone(),
          ),
        ),
      ),
    );
  }
}
