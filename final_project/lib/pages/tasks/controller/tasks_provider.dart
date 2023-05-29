import 'package:flutter/cupertino.dart';
import '../../../database/database.dart';
import '../../../models/task.dart';
import '../../../models/user.dart';

class TasksProvider extends ChangeNotifier {
  User? user;
  getUser(int id) async {
    return await DBHelper().getUser(id).then((map) {
      user = User.fromMap(map);
      getUserTasks();
    });
  }

  GlobalKey<FormState> form = GlobalKey();
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskTimeController = TextEditingController();
  TextEditingController taskDateController = TextEditingController();

  resetForm() {
    taskNameController.text = '';
    taskDescriptionController.text = '';
    taskTimeController.text = '';
    taskDateController.text = '';
  }

  Future<bool> insertTask() async {
    var task = Task.fromMap({
      'name': taskNameController.text,
      'description': taskDescriptionController.text,
      'stauts': 0,
      'user_id': user!.id,
      'time': taskTimeController.text,
      'date': taskDateController.text,
    });
    return await DBHelper().insertTask(task) > 0;
  }

  Future<bool> updateTask(Task t) async {
    t.name = taskNameController.text;
    t.description = taskDescriptionController.text;
    t.time = taskTimeController.text;
    t.date = taskDateController.text;
    return await DBHelper().updateTask(t) > 0;
  }

  List<Task> tasks = [];
  int taskFilter = -1;
  addFilter(int value) {
    taskFilter = value;
    getUserTasks();
    notifyListeners();
  }

  getUserTasks() {
    taskFilter == -1
        ? DBHelper().allUserTasks(user!).then((list) {
            tasks.clear();
            list.forEach((element) {
              tasks.add(Task.fromMap(element));
              notifyListeners();
            });
          })
        : DBHelper().filterTaskByStatus(taskFilter,user!.id!).then((list) {
            tasks.clear();
            list.forEach((element) {
              tasks.add(Task.fromMap(element));
              notifyListeners();
            });
          });
  }

  Future<bool> deleteTask(int id) async {
    return await DBHelper().deleteTask(id) > 0;
  }

  Future<bool> doneTask(Task task) async {
    task.stauts = 1;
    return await DBHelper().doneTask(task) > 0;
  }
}
