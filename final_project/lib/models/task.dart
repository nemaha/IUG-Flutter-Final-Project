class Task {
  int? id;
  String? name;
  String? description;
  int? stauts;
  int? userId;
  String? time; 
  String? date; 
  Task(dynamic obj) {
    id = obj['id'];
    name = obj['name'];
    description = obj['description'];
    stauts = obj['stauts'];
    userId = obj['user_id'];
    time = obj['time'];
    date = obj['date'];
  }
  Task.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    description = data['description'];
    stauts = data['stauts'];
    userId = data['user_id'];
    time = data['time'];
    date = data['date'];
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'stauts': stauts,
        'user_id': userId,
        'time': time,
        'date': date,
      };
}
