class TodoModel {
  final String id;
  final String title;
  final String description;
  final String createAt;
  final String updateAt;
  final bool isCompleted;
  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createAt,
    required this.updateAt,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'createAt': createAt});
    result.addAll({'updateAt': updateAt});
    result.addAll({'isCompleted': isCompleted});

    return result;
  }

  factory TodoModel.fromJson(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createAt: map['createAt'],
      updateAt: map['updateAt'],
      isCompleted: map['isCompleted'],
    );
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    String? createAt,
    String? updateAt,
    bool? isCompleted,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
