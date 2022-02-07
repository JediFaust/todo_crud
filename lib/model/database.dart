import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('tasks');

class Database {
  static String userUid = 'testuser';

  static Future<void> addItem({
    required String content,
  }) async {
    DateTime lastUpdated = DateTime.now();
    bool isDone = false;

    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "content": content,
      "last_updated": lastUpdated,
      "is_done": isDone,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Task added to the DB"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('items');

    return notesItemCollection.snapshots();
  }

  static Future<void> updateItem({
    required String? docId,
    required String? content,
    required bool? isDone,
  }) async {
    DateTime lastUpdated = DateTime.now();

    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "content": content,
      "last_updated": lastUpdated,
      "is_done": isDone,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Task updated on the DB"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('items').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Task is deleted from DB'))
        .catchError((e) => print(e));
  }
}
