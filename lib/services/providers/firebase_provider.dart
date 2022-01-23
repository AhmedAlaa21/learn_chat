import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learn_chat/constants/constants.dart';

class FirebaseProvider{

  addMessage({required String text, required String sender, required DateTime createdAt}) async {
   CollectionReference _collectionReference =
         FirebaseFirestore.instance.collection(kMessagesCollection);
    await _collectionReference.add({
      'message text': text,
      'sender': sender,
      'created At': createdAt,
    });
  }

  //getMessage({})
}
