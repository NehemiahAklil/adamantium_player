import 'package:adamantium_player/config/router.dart';
import 'package:adamantium_player/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Adamantium Player',
      theme: ThemeData(
        useMaterial3: true,
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
              fontFamily: 'Satoshi',
            ),
      ),
      routerConfig: router,
    );
  }
}
