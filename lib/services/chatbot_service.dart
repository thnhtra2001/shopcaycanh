// import 'dart:convert';
// import 'package:shopcaycanh/models/cart_item.dart';
// import 'package:shopcaycanh/models/message.dart';
// import 'package:shopcaycanh/models/product.dart';

// import '../models/cart_item1.dart';
// import '../models/order_item.dart';
// import './firebase_service.dart';
// import 'package:http/http.dart' as http;
// import 'auth_service.dart';

// class Chatbot{
//   Chatbot(): super();

//   Future<List<Message>> fetchMessage() async{
//     final List<Message> _message = [];
//     try{
//       final messageUrl = Uri.parse('http://localhost:5005/webhooks/rest/webhook');
//       final response = await http.get(messageUrl);
//       final messageMap = json.decode(response.body) as Map<String, dynamic>;

//       if(response.statusCode != 200){
//         print(messageMap['error']);
//         return _message;
//       }
//       print("AAAAAAAAAAAAAAAAAAAaa");
//       print(messageMap);

//       messageMap.forEach((id, mess) { 
//         _message.insert(0, Message.fromJson({'senderId': '1', ...mess}));

//       });

//       return _message;
//     }catch(error){
//       print(error);
//       return _message;
//     }
//   }

//   Future<Message?> addMessage(String senderId, String message) async{
//     try{
//       final url = Uri.parse('http://localhost:5005/webhooks/rest/webhook');
//       final response = await http.post(
//         url,
//         body: jsonEncode(<String, String>{'senderId': senderId, 'message': message})
//         );
    
//      print("CCCCCCCCCCCCCCCCCCc");
//       print(response);
//       if(response.statusCode != 200){
//         throw Exception(json.decode(response.body)['error']);
      
//       }
 
//     } catch(error){
//       print(error);
//       return null;
//     }
//   }
// }