class Task {
  int? id;
  int? user_id;
  String? title;
  String urgency;
  DateTime? due;
  int? isFinished;

  Task(
    this.id,
    this.user_id,
    this.title,
    this.urgency,
    this.due,
    this.isFinished,
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": user_id,
        "title": title,
        "urgency": urgency,
        "due": due.toString(),
        "isFinished": isFinished,
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json['id'] as int,
      json['user_id'] as int,
      json['title'] as String,
      json['urgency'] as String,
      DateTime.parse(json['due'].toString()),
      json['isFinished'] as int,
    );
  }
}
