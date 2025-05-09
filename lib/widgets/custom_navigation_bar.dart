import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:solar_icons/solar_icons.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.deepPurple.shade900.withValues(alpha: 0.9),
                Colors.deepPurple.shade900.withValues(alpha: 0.8),
                Colors.deepPurple.shade900.withValues(alpha: 0.6),
                Colors.deepPurple.shade900.withValues(alpha: 0.3),
                Colors.transparent,
              ]),
        ),
        child: BottomNavigationBar(
          elevation: 0.0,
          onTap: (selectedIndex) {
            switch (selectedIndex) {
              case 0:
                context.pushReplacement('/home');
                break;
              case 1:
                context.pushReplacement('/library');
                break;
              case 2:
                context.pushReplacement('/settings');
                break;
              default:
                context.pushReplacement('/home');
            }
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white.withValues(alpha: 0),
          // backgroundColor: Colors.deepPurple.shade800.withValues(alpha: 0.8),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(SolarIconsBold.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(SolarIconsBold.library), label: "My Library"),
            BottomNavigationBarItem(
                icon: Icon(SolarIconsBold.settings), label: "Settings"),
          ],
        ));
  }
}
