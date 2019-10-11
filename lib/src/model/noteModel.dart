import 'dart:convert';

Notes clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Notes.fromJson(jsonData);
}

String clientToJson(Notes data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Notes {
  String noteText;
  String noteDate;
  String category;
  String noteHour;
  bool blocked;
  int id;

  Notes({
    this.id,
    this.blocked,
    this.noteText,
    this.noteDate,
    this.noteHour,
    this.category,
  });

  factory Notes.fromJson(Map<String, dynamic> json) => new Notes(
    id: json["id"],
    blocked: json["blocked"] == 1,
    noteText: json["noteText"],
    noteDate: json["noteDate"],
    noteHour: json["noteHour"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "blocked": blocked,
    "noteText": noteText,
    "noteDate": noteDate,
    "noteHour": noteHour,
    "category": category,
  };
}