import 'package:flutter/material.dart';
import 'package:projekt_481_play_with_me/feature/info_courts/repositories/court_data.dart';
import 'package:projekt_481_play_with_me/config/colors.dart';

//lib/feature/info_courts/repositories/court_data.dart/';

class InfoFieldsScreen extends StatelessWidget {
  const InfoFieldsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Information header with dynamic court info
        Container(
          color: const Color.fromARGB(113, 0, 0, 0),
          width: 400,
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "     Platzinformation",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: oliveLeaf),
              ),

              // Display information for each court in a Row at the top
              Expanded(
                child: ListView.builder(
                  itemCount: courts.length,
                  itemBuilder: (context, index) {
                    final court = courts[index];
                    return Container(
                      color: getColorForCourt(index),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: ${court.name}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: deepKelp),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Standort: ${court.locationUrl}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: deepKelp),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Spieler: ${court.playerCount}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: deepKelp),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        // Horizontal ListView of court cards
        Container(
          color: const Color.fromARGB(62, 0, 0, 0),
          width: 400,
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(8),
            itemCount: courts.length,
            itemBuilder: (BuildContext context, int index) {
              final court = courts[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return FractionallySizedBox(
                        heightFactor: 0.7,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Color.fromARGB(255, 236, 250, 255),
                                Color.fromARGB(255, 97, 96, 105),
                              ],
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Name: ${court.name}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Location URL: ${court.locationUrl}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Image.asset(
                                  court.imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
                  width: 280,
                  height: 260,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          court.imageUrl,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            padding: const EdgeInsets.all(4),
                            child: Text(
                              court.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Button to create a new basketball court
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return const CreateCourtWidget();
              },
            );
          },
          child: Text(
            "Neue Basketballplatz erstellen",
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: teakwood,
                ),
          ),
        ),
      ],
    );
  }

  Color getColorForCourt(int index) {
    return index % 2 == 0 ? headInTheClouds : silkenTofu;
  }
}

// Separate widget for creating a new court
class CreateCourtWidget extends StatelessWidget {
  const CreateCourtWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Neuen Basketballplatz erstellen",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(labelText: "Name des Platzes"),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(labelText: "Standort "),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Platz Foto"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Google Standort"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Platz hinzufügen"),
          ),
        ],
      ),
    );
  }
}
