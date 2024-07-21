import 'dart:convert';

import 'package:http/http.dart' as http;

final String apiKey = 'avsQWVRQWR@3423424@#123asf';
final String apiUrl = 'https://apps.kode4u.tech/flutter/write_khmer/post.php';

Future<bool> updateLeaderboard(
    String userId, String userName, int totalScore, int rank) async {
  final Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  final Map<String, dynamic> data = {
    'user_id': userId,
    'user_name': userName,
    'total_score': totalScore.toString(),
    'rank': rank.toString(),
  };

  try {
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('Leaderboard updated successfully');
      return true;
    } else {
      print('Failed to update leaderboard: ${response.statusCode}');
      print(response.body);
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

void main() {
  updateLeaderboard('id001', 'titya', 100, 1);
}
