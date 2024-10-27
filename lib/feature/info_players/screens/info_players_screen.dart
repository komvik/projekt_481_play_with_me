import 'package:flutter/material.dart';
import 'package:projekt_481_play_with_me/feature/navigation_wrapper/repositories/player_data.dart';
import '../../navigation_wrapper/models/player_item.dart';

class InfoPlayersScreen extends StatefulWidget {
  const InfoPlayersScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InfoPlayersScreenState createState() => _InfoPlayersScreenState();
}

class _InfoPlayersScreenState extends State<InfoPlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //___________________________________ Online status indicator
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Circular status indicator
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: player.online ? Colors.green : Colors.red,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      player.online ? "Online" : "Offline",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // _______________________________Checkbox to send message
                    Checkbox(
                      value: player.sendMessage,
                      onChanged: player.online
                          ? (bool? value) {
                              setState(() {
                                players[index] = PlayerProfil(
                                  firstName: player.firstName,
                                  lastName: player.lastName,
                                  nickName: player.nickName,
                                  avatarUrl: player.avatarUrl,
                                  availavility: player.availavility,
                                  sendMessage: value ?? false,
                                  online: player.online,
                                );

                                if (value == true) {
                                  final TextEditingController
                                      messageController =
                                      TextEditingController();

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            " Nachricht für ${player.firstName}"),
                                        content: TextField(
                                          controller: messageController,
                                          decoration: const InputDecoration(
                                            hintText:
                                                "Geben Sie Ihre Nachricht ein",
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              // !!__!!__!!
                                              //    Logic
                                              // String message = messageController.text;
                                              // Here you can add code to handle sending a message
                                              // print(" message -> ${player.firstName}: $message");
                                              //

                                              // Notification that the message has been sent
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Nachricht gesendet!"),
                                                ),
                                              );

                                              // After sending the message, return the checkbox to the false state
                                              setState(() {
                                                players[index] = PlayerProfil(
                                                  firstName: player.firstName,
                                                  lastName: player.lastName,
                                                  nickName: player.nickName,
                                                  avatarUrl: player.avatarUrl,
                                                  availavility:
                                                      player.availavility,
                                                  sendMessage:
                                                      false, // Return the checkbox state to false
                                                  online: player.online,
                                                );
                                              });

                                              Navigator.of(context)
                                                  .pop(); //Close dialog
                                            },
                                            child: const Text("Schicken"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              // Return the checkbox to false when canceled
                                              setState(() {
                                                players[index] = PlayerProfil(
                                                  firstName: player.firstName,
                                                  lastName: player.lastName,
                                                  nickName: player.nickName,
                                                  avatarUrl: player.avatarUrl,
                                                  availavility:
                                                      player.availavility,
                                                  sendMessage:
                                                      false, // Reset checkbox state
                                                  online: player.online,
                                                );
                                              });

                                              Navigator.of(context)
                                                  .pop(); // Close dialog without sending
                                            },
                                            child: const Text("Abbrechen"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              });
                            }
                          : null, // If offline, disable Checkbox
                    ),
                  ],
                ),
                const SizedBox(width: 8), // Space between status and avatar

                // ________________________________________  AVATAR
                CircleAvatar(
                  radius: 24,
                  backgroundImage: player.avatarUrl.isNotEmpty
                      ? AssetImage(player.avatarUrl)
                      : const AssetImage("assets/images_avatar/avatar1.png"),
                ),
                const SizedBox(width: 8),

                //__________________________________________ INFO PLAYER
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${player.firstName} ${player.lastName}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        " ${player.nickName}", //Nickname
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),

                      // ________________________  Availability
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 4,
                        children: player.availavility.map((status) {
                          return Chip(
                            label: Text(
                              status,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: status == 'Ja'
                                ? Colors.green[100]
                                : status == 'Vielleicht'
                                    ? Colors.orange[100]
                                    : Colors.red[100],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
