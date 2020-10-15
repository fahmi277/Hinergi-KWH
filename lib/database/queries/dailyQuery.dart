class DailyQuery {
  static const String TABLE_NAME = "daily";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}
