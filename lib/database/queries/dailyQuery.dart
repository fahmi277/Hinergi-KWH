class DailyQuery {
  static const String TABLE_NAME = "daily";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";

//   void setData(){

//      String name = 'Bob';
// int age = 23;
// db.rawInsert(
//     'INSERT INTO ${DatabaseHelper.table}'
//         '(${DatabaseHelper.columnName}, ${DatabaseHelper.columnAge}) '
//         'VALUES(?, ?)', [name, age]);

//   }

}
