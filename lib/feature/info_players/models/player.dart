import "dart:convert";

class Player {
  final String userId;
  final String eMail;
  final String password;
  final String firstName;
  final String lastName;
  final String nickName;
  final String avatarUrl;
  final List<String> availability;
  final bool sendMessage;
  final bool online;

  Player({
    this.userId = "",
    required this.eMail,
    required this.password,
    this.firstName = "Max",
    this.lastName = "Mustermann",
    this.nickName = "-",
    this.avatarUrl = "assets/images_avatar/avatar1.png",
    this.availability = const ['Ja', 'Vielleicht', 'Nein'],
    this.sendMessage = false,
    this.online = false,
  });

// serelisirung
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
      'eMail': eMail,
      'password': password,
      'avatarUrl': avatarUrl,
      'availability': availability,
      'sendMessage': sendMessage,
      'online': online,
    };
  }

  // de serelisirung
  static Player fromJson(Map<String, dynamic> json) {
    return Player(
      userId: json['userId'] ?? "",
      firstName: json['firstName'] ?? "Max",
      lastName: json['lastName'] ?? "Mustermann",
      nickName: json['nickName'] ?? "-",
      eMail: json['eMail'] ?? "example@email.mail",
      password: json['password'] ?? "",
      avatarUrl: json['avatarUrl'] ?? "assets/images_avatar/avatar1.png",
      availability: List<String>.from(json['availability'] ?? []),
      sendMessage: json['sendMessage'] ?? false,
      online: json['online'] ?? false,
    );
  }

  // player->to json
  static String encodePlayers(List<Player> players) {
    List<Map<String, dynamic>> playerMaps =
        players.map((player) => player.toJson()).toList();
    return jsonEncode(playerMaps);
  }

  // json->to player
  static List<Player> decodePlayers(String playersJson) {
    List<dynamic> playerList = jsonDecode(playersJson);
    return playerList.map((playerJson) => Player.fromJson(playerJson)).toList();
  }
}
