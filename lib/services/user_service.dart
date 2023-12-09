import 'dart:convert';
import 'package:shopcaycanh/models/user_use_app.dart';

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

  Future<List<UserUseApp>> fetchAllUser() async {
    late List<UserUseApp> _users = [];
    try {
      // final uid = (await AuthService().loadSavedAuthToken())!.userId;
      final userInforUrl =
          Uri.parse('$databaseUrl/users.json?auth=$token&orderBy="uid"');
      final response = await http.get(userInforUrl);
      final usersAll = json.decode(response.body) as Map<dynamic, dynamic>;
      print("quan li nguoi dung");
      print(response.body);

      if (response.statusCode != 200) {
        return _users;
      }
      usersAll.forEach((uid, value) {
        _users.add(UserUseApp.fromJson({'uid': uid, ...value}));
      });
      print("LENGTH:");
      print(_users.length);
      return _users;
    } catch (error) {
      print(error);
      return _users;
    }
  }

    Future<bool> deleteUser(String uid) async {
    try {
      print("UID LA");
      print(uid);
      final url = Uri.parse('$databaseUrl/users.json?/${uid}.json?auth=$token');
      final response = await http.delete(url);

      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
