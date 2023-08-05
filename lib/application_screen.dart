import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_firebase/auth/presentation/login_screen.dart';
import 'package:todo_app_with_firebase/shared/app_routes.dart';
import 'package:todo_app_with_firebase/todo/todo_services.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  late TextEditingController _descriptionController;
  late TextEditingController _titleController;
  late TodoServices _todoServices;
  bool _isLoading = false;

  @override
  void initState() {
    _todoServices = TodoServices();
    _descriptionController = TextEditingController();
    _titleController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App with Firebase'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              setRoot(
                context,
                const LoginScreen(),
              );
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _todoServices.todosCollection.snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
        ) {
          if (!snapshot.hasData) {
            return const Center(
              child: CupertinoActivityIndicator(radius: 30),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          var docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text('Aucune donnees'));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data();

              return ListTile(
                title: Text('${data['title']}'),
                subtitle: Text('${data['description']}'),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showGeneralDialog(
            barrierLabel: 'Add Todo',
            barrierDismissible: true,
            context: context,
            pageBuilder: (context, animation, secondaryAnimation) {
              return AlertDialog(
                title: const Text("Add Todo"),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        await _todoServices.addTodo(
                          data: {
                            'title': _titleController.text,
                            'description': _descriptionController.text,
                          },
                        );
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.pop(context);
                      } catch (e) {
                        setState(() {
                          _isLoading = false;
                        });
                        print(e);
                      }
                    },
                    child: _isLoading
                        ? const CupertinoActivityIndicator()
                        : const Text('Add'),
                  )
                ],
                content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          label: Text("Title"),
                          hintText: 'Todo Title',
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          label: Text("Description"),
                          hintText: 'Todo description',
                        ),
                      ),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              );
            },
          );
        },
        label: const Text('Add Todo'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
