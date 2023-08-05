import 'package:cloud_firestore/cloud_firestore.dart';

class TodoServices {
  final todosCollection = FirebaseFirestore.instance.collection('todos');

  addTodo({required Map<String, dynamic> data}) async {
    return await todosCollection.add(data);
  }
}
