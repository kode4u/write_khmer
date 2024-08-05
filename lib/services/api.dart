import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../states/app_state.dart';

final String url =
    'https://apps.kode4u.tech/flutter/write_khmer/leaderboard.php';
final String api =
    'b4dbdba573c5780d49f68082eed8f2f29a5740e2d10981cf8fcd2ff528fccc31';
Future<void> createUser(int totalScore, String name) async {
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'API_KEY':
          'b4dbdba573c5780d49f68082eed8f2f29a5740e2d10981cf8fcd2ff528fccc31',
    },
    body: {
      'api': api,
      'action': 'create_user',
      'username': name,
      'totalscore': totalScore.toString(),
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['status'] == 'success') {
      print('User created successfully. User ID: ${responseData['id']}');
      GetStorage g = GetStorage();
      g.write('user', {'username': name, 'id': responseData['id']});
      AppState app = Get.find<AppState>();
      app.user.value = {'username': name, 'id': responseData['id']};
    } else {
      print('Failed to create user: ${responseData['message']}');
    }
  } else {
    print(response.statusCode);
    print('Failed to connect to the server');
  }
}

Future<void> updateUserScore(String userId, int totalScore) async {
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'API_KEY':
          'b4dbdba573c5780d49f68082eed8f2f29a5740e2d10981cf8fcd2ff528fccc31',
    },
    body: {
      'api': api,
      'action': 'update_score',
      'id': userId,
      'totalscore': totalScore.toString(),
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    if (responseData['status'] == 'success') {
      print('User score updated successfully');
    } else {
      print('Failed to update user score: ${responseData['message']}');
    }
  } else {
    print('Failed to connect to the server');
  }
}

// Function to query the leaderboard
Future<List<LeaderboardEntry>> queryLeaderboard() async {
  final response = await http.post(
    Uri.parse(url),
    body: {
      'api': api,
      'action': 'query_leaderboard',
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status'] == 'success') {
      List<dynamic> data = jsonResponse['data'];
      return data.map((entry) => LeaderboardEntry.fromJson(entry)).toList();
    } else {
      throw Exception(jsonResponse['message']);
    }
  } else {
    throw Exception('Failed to query leaderboard');
  }
}

class LeaderboardEntry {
  final String id;
  final String username;
  final int totalscore;
  final int rank;
  final int star;

  LeaderboardEntry({
    required this.id,
    required this.username,
    required this.totalscore,
    required this.rank,
    required this.star,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'],
      username: json['username'],
      totalscore: int.parse('${json['totalscore']}'),
      rank: int.parse('${json['rank']}'),
      star: int.parse('${json['star']}'),
    );
  }
}

void main() async {
  // updateUserScore('user_66af629a65dc81.93988988', 12);
  // print(await queryLeaderboard());

  // createUser(64, 'paopao');
  // createUser(190, 'chutima');
  // createUser(130, 'sivmey');
  // createUser(80, 'panhone');
  // createUser(160, 'titya');
  // createUser(110, 'kakada');
  // createUser(70, 'channy');
  createUser(70, 'pikachu');
  createUser(200, 'labubu');
  createUser(70, 'cr7');
  createUser(130, 'messi');
  createUser(70, 'tom');
  createUser(70, 'jerry');
  createUser(70, 'sethika');
  createUser(160, 'puthisa');
}
