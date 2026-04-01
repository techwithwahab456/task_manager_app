import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager_app/app/models/task_model.dart';
import 'package:task_manager_app/app/models/user_model.dart';

class DatabaseServicess { 
 static final  DatabaseServicess _instance=DatabaseServicess.internal();
 factory DatabaseServicess()=>_instance;
 DatabaseServicess.internal();
 static Database? _database;
 Future<Database> get database async{ 
  if(_database!=null)return _database!;
   _database=await _initDatabase();
  return _database!;
 }
 Future<Database> _initDatabase()async{ 
  String path=join(await getDatabasesPath(),'tasks.db');
  return await openDatabase(path,
  version: 1,
  onCreate: _onCreate,
 );
 }
 Future<void> _onCreate(Database db,int version)async{ 
  await db.execute(''' 
  CREATE TABLE user( 
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT UNIQUE,
        password TEXT,
        createdAt TEXT,
        logIn INTEGER)''');
  await db.execute( '''
    CREATE TABLE tasks( 
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    description TEXT,
    isCompleted INTEGER,
    createdAt TEXT,
     userId INTEGER,
      priority TEXT,
  deadline TEXT 

     
    )
    '''
  );

 }
//  Future<void> _onUpgrade(Database db,int oldversion,int newversion)async{ 
//   if(oldversion<2){ 
//     await db.execute('ALTER TABLE tasks ADD COLUMN userId INTEGER');
//     await db.execute('''  
//     CREATE TABLE IF NOT EXISTS user( 
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     email TEXT UNIQUE,
//     password TEXT,
//     createdAt TEXT
//     )''');
//   }
//  }
 Future<int> insertuser(User user)async{ 
  Database db=await database;
  return db.insert('user', user.toMap());
 }
 Future<User?> getuserById(int id)async{ 
  final Database db=await database;
  final List<Map<String,dynamic>> map=await db.query('user',
  where: 'id=?',
  whereArgs:[id] );
  if(map.isNotEmpty){ 
    return User.fromMap(map.first);
  }
  return null;
 }
 Future<void> logoutUser(int id)async{ 
  final Database db=await database;
   await db.update('user',{'logIn':0});
 }
 Future<User?> getuserbyEmail(String email)async{ 
  final Database db=await database;
  final List<Map<String,dynamic>> map=await db.query('user',
  where: 'email=?',
  whereArgs: [email]);
  if(map.isNotEmpty){ 
    return User.fromMap(map.first);
  }
  return null;
  }
 Future<int> insertTasks(Task task)async{ 
  Database db=await database;
  return db.insert('tasks', task.toMap());
 }
 Future<List<Task>> getTasks(int userId)async{
  final Database db=await database;
  final List<Map<String,dynamic>> map=await db.query('tasks',
  where: 'userId=?',
  whereArgs: [userId]) ;
  return List.generate(map.length, (i)=>Task.fromMap(map[i]));

 }
 Future<int> updateTask(Task task)async{ 
  final Database db=await database;
  return db.update('tasks', task.toMap(),
  where: 'id=?',
  whereArgs: [task.id]);

 }
 Future<int> deleteTask(int id)async{ 
  final Database db=await database;
  return db.delete('tasks',
  where: 'id=?',
  whereArgs: [id]);
 }
   Future<int> deleteAllTasksForUser(int userId) async {
    Database db = await database;
    return await db.delete('tasks', where: 'userId = ?', whereArgs: [userId]);
  }

}