import 'dart:convert';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/shared/app_drawer.dart';

class ChatbotScreen1 extends StatefulWidget {
  static const routeName = '/chatbot';
  const ChatbotScreen1({super.key});
  @override
  _ChatbotScreen1State createState() => _ChatbotScreen1State();
}

class _ChatbotScreen1State extends State<ChatbotScreen1> {
  final messageInsert = TextEditingController();
  List<Map> _message = [];
  Future<void> _sendMessage(String message) async {
    final http.Response response = await http.post(
      Uri.parse('https://98ba-123-28-165-104.ngrok.io/webhooks/rest/webhook'),
          headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({"sender": "user", "message": message}),
    );
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        // _response = responseData.isNotEmpty ? responseData.first['text'] : 'No response';
        _message.insert(0, {"data": 0, "message": responseData.first['text']});
      });
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Chatbot",
        ),
      ),
      drawer: const AppDrawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                "Hôm nay, ${DateFormat("Hm").format(DateTime.now())}",
                style:const TextStyle(fontSize: 15),
              ),
            ),
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    itemCount: _message.length,
                    itemBuilder: (context, index) => chat(
                        _message[index]["data"],
                        _message[index]["message"].toString()))),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 5.0,
              color: Colors.grey,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromRGBO(220, 220, 220, 1),
                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageInsert,
                    decoration: const InputDecoration(
                      hintText: "Nhập câu hỏi...",
                      hintStyle: TextStyle(color: Colors.black26),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    onChanged: (value) {},
                  ),
                ),
                trailing: IconButton(
                    icon: const Icon(
                      Icons.send,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      if (messageInsert.text.isEmpty) {
                        print("empty message");
                      } else {
                        setState(() {
                          _message.insert(
                              0, {"data": 1, "message": messageInsert.text});
                        });
                        // context.read<MessageManager>().addMessage('0', messageInsert.text);
                        _sendMessage(messageInsert.text);
                        messageInsert.clear();
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                    }),
              ),
            ),
            const SizedBox(
              height: 15.0,
            )
          ],
        ),
      ),
    );
  }

  //for better one i have use the bubble package check out the pubspec.yaml

  Widget chat(int data, String message) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 40,
                  width: 40,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/Images/robot-icon.png"),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 0 ? Colors.grey : Colors.purple,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: Text(
                          message,
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 40,
                  width: 40,
                  child: const CircleAvatar(
                    backgroundImage: AssetImage("assets/Images/user-icon.png"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
