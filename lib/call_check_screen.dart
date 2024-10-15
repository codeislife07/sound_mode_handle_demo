import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:vibration/vibration.dart';

class CallCheckScreen extends StatefulWidget {
  const CallCheckScreen({super.key});

  @override
  State<CallCheckScreen> createState() => _CallCheckScreenState();
}

class _CallCheckScreenState extends State<CallCheckScreen> {
  late AudioPlayer player;

  late RingerModeStatus status;

  @override
  void initState() {
    checkSoundMode();
    super.initState();
  }

  Future<void> checkSoundMode() async {
    player = AudioPlayer();
    RingerModeStatus ringerStatus = await SoundMode.ringerModeStatus;
    status = ringerStatus;
    setState(() {});
    switch (ringerStatus) {
      case RingerModeStatus.silent:
        break;
      case RingerModeStatus.vibrate:
        Vibration.vibrate(duration: 10000, pattern: [
          500, //0.5 second delay
          1000, //vibrate for 1 second
          500,
          1000,
          500,
          1000,
          500,
          1000,
          500,
          1000,
          500,
          1000,
          500,
          1000,
          500,
          1000,
          500,
          1000,
          500,
          1000
        ]);
        break;
      default:
        await player.setAsset(// Load a URL
            'assets/music/ringtone.mp3'); // Schemes: (https: | file: | asset: )
        player.play();
        break;
    }
  }

  @override
  void dispose() {
    try {
      Vibration.cancel();
      player.stop();
    } catch (e) {
      print("Error in dispose");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text(status.toString())],
            ),
          ),
        ),
      ),
    );
  }
}
