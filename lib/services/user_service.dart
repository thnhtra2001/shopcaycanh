import 'dart:convert';
import '../services/firebase_service.dart';
import 'package:http/http.dart' as http;
import '../services/auth_service.dart';

class UserService extends FirebaseService {
  UserService() : super();

  Future<Map<String, dynamic>> fetchUserInformation() async {
    late Map<String, dynamic> data = {};
    try {
      final uid = (await AuthService().loadSavedAuthToken())!.userId;
      final userInforUrl = Uri.parse(
          '$databaseUrl/users.json?auth=$token&orderBy="uid"&equalTo="$uid"');
      final response = await http.get(userInforUrl);
      data = json.decode(response.body);
      var key = data.keys.first;
      data = data[key];

      if (response.statusCode != 200) {
        return data;
      }

      return data;
    } catch (error) {
      print(error);
      return data;
    }
  }

  Future<void> updateUserInformation(Map<String, dynamic> updateInfor) async {
    try {
      final uid = (await AuthService().loadSavedAuthToken())!.userId;
      final userInforUrl = Uri.parse(
          '$databaseUrl/users.json?auth=$token&orderBy="uid"&equalTo="$uid"');
      final response = await http.get(userInforUrl);
      var key = json.decode(response.body).keys.first;

      final updateUrl = Uri.parse('$databaseUrl/users/${key}.json?auth=$token');
      final updateResponse =
          await http.patch(updateUrl, body: json.encode(updateInfor));

      if (updateResponse.statusCode != 200) {
        throw Exception(json.decode(updateResponse.body)['error']);
      }
    } catch (error) {
      print(error);
    }
  }
}
