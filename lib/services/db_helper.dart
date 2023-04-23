import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database? db;
  static final int version = 1;
  static final String tableName = "token";
  static List<Map> tokens = [];
  static var idToken = [] ;


  static Future<void> initDb()async{
    if(db != null){
      print("not null db");
      return;
    }else{
      try{
        String path = await getDatabasesPath() + "token";
        db = await openDatabase(
            path,
            version: version,
            onCreate: (Database db, int version) async {
              await db.execute(
                  'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, name TEXT , videourl TEXT)');
            },
            onOpen: (db){
              getDataFromDb(db).then((value) {
                value.forEach((element) {
                  idToken.add(element['name']);
                });
                print(idToken);
              });
            }
        );
      }catch(e){
        print(e.toString());
      }
    }

  }

  static Future insertDatabase({required String? uid})async {
    return await db!.transaction((txn) {
      return
        txn.rawInsert('INSERT INTO $tableName(name) VALUES( "$uid")')
            .then((value) {
          print('$value insert successful');
          print(tableName);
        })
            .catchError((e)
        {
          print(e.toString());

        });
    });
  }

  static Future<List<Map>> getDataFromDb(db)async{
    return await db!.rawQuery('SELECT * FROM token');
  }
}