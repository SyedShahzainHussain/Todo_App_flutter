class TodoModel {
  final String id;
  String text;
  bool isChecked;

  TodoModel({
    required this.id,
    required this.text,
    required this.isChecked,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['id'] = id;
    json['text'] = text;
    json['isChecked'] = isChecked;
    return json;
  }

  factory TodoModel.fromJSON(Map<String, dynamic> map) => TodoModel(
        id: map['id'],
        isChecked: map['isChecked'],
        text: map['text'],
      );
}
