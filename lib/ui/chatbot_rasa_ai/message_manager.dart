import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart';
import 'package:shopcaycanh/models/message.dart';
import 'package:shopcaycanh/services/chatbot_service.dart';

class MessageManager with ChangeNotifier {
  final Chatbot _chatbotSer = Chatbot();
  late List<Message> _message = [];

  List<Message> get message {
    return [..._message];
  }

  Future<void> fetchMessage() async {
    _message = await _chatbotSer.fetchMessage();
    print(_message.length);
    notifyListeners();
  }

  Future<void> addMessage(String senderId, String message) async {
    final newMess = await _chatbotSer.addMessage(senderId, message);
    if (newMess != null) {
      _message.insert(0, newMess);
      // _orders.add(newOrder);
      notifyListeners();
    }
  }
}
