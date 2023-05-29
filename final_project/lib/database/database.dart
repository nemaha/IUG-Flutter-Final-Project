import 'package:final_project/models/task.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();
  static Database? _db;


  Future<Database> createDataBase() async {
    if (_db != null) {
      return _db!;
    }
    // define the path to the database
    String path = join(await getDatabasesPath(), 'tasks.db');
    _db = await openDatabase(path, version: 1, onCreate: (Database db, int v) {
      db.execute(
          'create table users(id integer primary key autoincrement , email varchar(50) , name varchar(50) , password varchar(50))');
      db.execute(
          'create table tasks(id integer primary key autoincrement , name varchar(50) , description varchar(250) , stauts integer , user_id integer , time varchar(50), date varchar(50))');
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      await db.execute('Alter table users add column level varchar(50)');
      await db.execute('Alter table tasks add column level varchar(50)');
    });
    return _db!;
  }

  Future<int> insertUser(User user) async {
    Database db = await createDataBase();
    return db.insert('users', user.toMap());
  }

  Future<List> allUsers() async {
    Database db = await createDataBase();
    return db.query('users');
  }

  Future<int?> userLogin(String email, String password) async {
    Database db = await createDataBase();
    var list = await db.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    return list.length > 0 ? int.parse(list.first['id'].toString()) : null;
  }

  Future<Map> getUser(int id) async {
    Database db = await createDataBase();
    var list = await db.query('users', where: 'id = ?', whereArgs: [id]);
    return list.first;
  }

  Future<int> updateUser(User User) async {
    Database db = await createDataBase();
    return db
        .update('users', User.toMap(), where: 'id = ?', whereArgs: [User.id]);
  }

  Future<int> insertTask(Task task) async {
    Database db = await createDataBase();
    return db.insert('tasks', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    Database db = await createDataBase();
    return db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  Future<List> allUserTasks(User user) async {
    Database db = await createDataBase();
    return db.query('tasks', where: 'user_id = ?', whereArgs: [user.id]);
  }

  Future<List> filterTaskByStatus(int status,int user_id) async {
    Database db = await createDataBase();
    return db
        .query('tasks', where: 'stauts = ? AND user_id = ?', whereArgs: [status.toString(),user_id.toString()]);
  }

  Future<int> deleteTask(int id) async {
    Database db = await createDataBase();
    return db.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> doneTask(Task task) async {
    Database db = await createDataBase();
    return db
        .update('tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }
}
