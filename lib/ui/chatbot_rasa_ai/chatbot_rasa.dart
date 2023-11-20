import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopcaycanh/ui/shared/app_drawer.dart';
import 'package:bubble/bubble.dart';

class ChatbotScreen extends StatefulWidget {
  static const routeName = '/chatbot';
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final messageController = TextEditingController();
  List<Map>? message = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chatbot'),
        ),
        drawer: const AppDrawer(),
        body: Container(
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  child: Text(
                    'Hôm nay, ${DateFormat("Hm").format(DateTime.now())}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Flexible(
                  child: ListView.builder(
                reverse: true,
                itemCount: 0,
                itemBuilder: (context, index) => chat(
                    message![index]['message'].toString(),
                    message![index]['data']),
              )),
              Divider(
                height: 5,
                color: Colors.black,
              ),
              Container(
                child: ListTile(
                  title: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(220, 220, 220, 1),
                    ),
                    padding: EdgeInsets.only(left: 15),
                    child: TextFormField(
                      controller: messageController,
                      decoration: const InputDecoration(
                        hintText: "Nhập câu hỏi",
                        hintStyle: TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        if (messageController.text.isEmpty) {
                          print("message is empty");
                        } else {
                          setState(() {
                            message!.insert(0,
                                {"data": 1, "message": messageController.text});
                          });
                          // response(messageController.text);
                          messageController.clear();
                          print("message da gui");
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: Colors.black,
                      )),
                ),
              )
            ],
          ),
        ));
  }

  Widget chat(String message, int data) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment:
            data == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          data == 0
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/robot.jpg"),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Bubble(
                radius: Radius.circular(15.0),
                color: data == 0
                    ? Color.fromRGBO(23, 157, 139, 1)
                    : Colors.orangeAccent,
                elevation: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 10.0,
                      ),
                      Flexible(
                          child: Container(
                        constraints: BoxConstraints(maxWidth: 200),
                        child: Text(
                          message,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ))
                    ],
                  ),
                )),
          ),
          data == 1
              ? Container(
                  height: 60,
                  width: 60,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/default.jpg"),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
