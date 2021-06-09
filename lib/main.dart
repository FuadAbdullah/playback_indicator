import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/ui/sound_player_ui.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(IndicatorApp());
}

class IndicatorApp extends StatelessWidget {
  const IndicatorApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Audio Playback Display",
        debugShowCheckedModeBanner: false,
        home: IndicatorAppCore());
  }
}

class IndicatorAppCore extends StatefulWidget {
  const IndicatorAppCore({Key key}) : super(key: key);

  @override
  _IndicatorAppCoreState createState() => _IndicatorAppCoreState();
}

class _IndicatorAppCoreState extends State<IndicatorAppCore> {
  var playerStateKey = GlobalKey<SoundPlayerUIState>();
  var audioBuffer, player;
  Track track;

  @override
  void initState() {
    player = SoundPlayerUI.fromLoader(
      (context) => onLoad(),
      showTitle: true,
    );
    super.initState();
  }

  Future<Track> onLoad() async {
    var audioData = await rootBundle.load('assets/audio/audio.mp3');
    Uint8List audioList = audioData.buffer.asUint8List();
    audioBuffer = audioList;
    return track = Track(
        dataBuffer: audioBuffer,
        codec: Codec.defaultCodec,
        trackTitle: "Kursi",
        trackAuthor: "Quran");
  }

  void chooseAudio() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Audio Playback Display"),
          centerTitle: true,
        ),
        endDrawer: Drawer(),
        body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/img/albumart.png'),
                ),
                Padding(padding: const EdgeInsets.all(30.0), child: player)
              ],
            )));
  }
}
