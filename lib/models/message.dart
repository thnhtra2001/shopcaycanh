import 'dart:convert';
import 'package:flutter/material.dart';

class Message with ChangeNotifier {
  late String? senderId;
  late String? message;

  Message({required this.senderId, required this.message});
  Message copyWith({String? senderId, String? message}) {
    return Message(
        senderId: senderId ?? this.senderId, message: message ?? this.message);
  }

  Map toJson() {
    return {'message': message};
  }

  factory Message.fromJson(Map<String, String> json) {
    return Message(senderId: json['senderId'], message: json['message']);
  }
}
