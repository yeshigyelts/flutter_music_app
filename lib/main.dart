import 'package:flutter/material.dart';
import 'package:music_app/screens/music.dart';

void main() => runApp(
      MaterialApp(
        title: 'Memes Life',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: MusicApp(),
      ),
    );
