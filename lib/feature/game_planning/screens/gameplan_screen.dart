import 'package:flutter/material.dart';
import 'package:projekt_481_play_with_me/feature/authorization/screens/authorization_screen.dart';

class GamePlanningScreen extends StatelessWidget {
  const GamePlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Spielplanung"),
        const SizedBox(height: 200),
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AuthorizationScreen()));
            },
            child: const Text(
              "Ausloggen",
              style: TextStyle(fontSize: 30),
            )),
      ],
    );
  }
}