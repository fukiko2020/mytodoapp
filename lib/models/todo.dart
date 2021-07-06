class TodoModel {
  final int id;
  final String content;
  bool? isDone;

  toggleDone(bool? value) {
    isDone = value;
  }

  TodoModel({
    required this.id,
    required this.content,
    this.isDone,
  });

  Map<String, dynamic> toMap() {
    int isDoneInt = isDone! ? 1 : 0;
    return {
      'id': id,
      'content': content,
      'isDone': isDoneInt,
    };
  }

  @override
  String toString() {
    return 'Todo {id: $id, content: $content, isDone: $isDone}';
  }
}
