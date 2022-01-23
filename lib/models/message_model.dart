import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? messageText;
  String? sender; // id
  Timestamp? createdAt;

  MessageModel({this.messageText, this.sender, this.createdAt});

  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      messageText: jsonData['message text'],
      sender: jsonData['sender'],
      createdAt: jsonData['created At'],
    );
  }

  String? get message => messageText;
}
