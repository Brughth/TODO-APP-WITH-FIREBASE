import 'package:cloud_firestore/cloud_firestore.dart';

class TodoServices {
  final todosCollection = FirebaseFirestore.instance.collection('todos');

  addTodo({required Map<String, dynamic> data}) async {
    var now = DateTime.now().toUtc().toIso8601String();
    data['createAt'] = now;
    data['updateAt'] = now;
    return await todosCollection.add(data);
  }

  updateTodo({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    data['updateAt'] = DateTime.now().toUtc().toIso8601String();
    return await todosCollection.doc(id).set(data, SetOptions(merge: true));
  }

  deleteTodo({
    required String id,
  }) async {
    return await todosCollection.doc(id).delete();
  }
}
