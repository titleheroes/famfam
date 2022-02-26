import 'package:famfam/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'famfam.db';
  final int version = 1;
  final String tableDatabase = 'user';

  final String columnID = 'id';
  final String userID = 'uid';
  final String profileImage = 'profileImage';
  final String columnFullname = 'fname';
  final String columnLastname = 'lname';
  final String columnPhone = 'phone';
  final String columnBirth = 'birth';
  final String columnAddress = 'address';
  final String columnPersonalID = 'personalID';
  final String columnJobs = 'jobs';

  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    // user
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => db.execute(
          "CREATE TABLE $tableDatabase ($columnID INTEGER PRIMARY KEY, $userID TEXT, $profileImage TEXT, $columnFullname TEXT, $columnLastname TEXT, $columnPhone TEXT, $columnBirth DATETIME,  $columnAddress TEXT, $columnPersonalID TEXT, $columnJobs TEXT)"),
      version: version,
    );
    // await openDatabase(
    //   join(await getDatabasesPath(), nameDatabase),
    //   onCreate: (db, version) => db.execute(
    //       "CREATE TABLE $tableDatabase ($columnID INTEGER PRIMARY KEY, $userID TEXT, $profileImage TEXT, $columnFullname TEXT, $columnLastname TEXT, $columnPhone TEXT, $columnBirth DATETIME,  $columnAddress TEXT, $columnPersonalID TEXT, $columnJobs TEXT)"),
    //   version: version,
    // );
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<List<UserModel>> readSQLite() async {
    Database database = await connectedDatabase();
    List<UserModel> results = [];
    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    print('### maps on UserModel ===> $maps');
    for (var item in maps) {
      UserModel model = UserModel.fromMap(item);
      results.add(model);
    }
    return results;
  }

  Future<Null> insertValueTOSQLite(UserModel userModel) async {
    Database database = await connectedDatabase();
    await database.insert(tableDatabase, userModel.toMap()).then((value) {
      print('#### Insert value name ==>> ${userModel.fname}');
    });
  }
}
