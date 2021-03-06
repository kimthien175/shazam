import 'package:acr_test/services/acr.dart';
import 'package:acr_test/services/player.dart';
import 'package:acr_test/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Acr.getInstance().init().catchError((e) => print(e));
  // Test
  //await DeezerSample.getInstance().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Player.getInstance().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Material App', home: Home());
  }
}
