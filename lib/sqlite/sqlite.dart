import './model/saddleTypeModel.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  String _dbDir;
  String _dbName = 'search.db';
  Database _db;

  // 初始化数据库
  initDB() async {
    _dbDir = await getDatabasesPath();
    _db = await openDatabase(p.join(_dbDir, _dbName), onCreate: (db, vsersion) {
      // 声明数据库中有哪些表结构
      return db.execute('''
        Create Table tbl_saddleType(
          id integer primary key,
          typeLevel text,
          diameter text,
          allowableLoad text,
          bearingHeight text,
          bottomPlate blob,
          webPlate text,
          ribPlate blob,
          backPlate blob,
          boltSpace blob,
          bearingQuality text,
          addQuality text,
          picUrl text
        )
      ''');
    }, version: 6);
  }

  // 关闭数据库
  closeDB() async {
    await _db.close();
  }

  // 添加一条数据
  addSaddleType(
      int id,
      String typeLevel,
      String diameter,
      String allowableLoad,
      String bearingHeight,
      String bottomPlate,
      String webPlate,
      String ribPlate,
      String backPlate,
      String boltSpace,
      String bearingQuality,
      String addQuality,
      String picUrl) async {
    // 最后参数要加逗号
    SaddleTypeModel saddleTypeModel = SaddleTypeModel(
      id:id,
      typeLevel:typeLevel,
      diameter:diameter,
      allowableLoad:allowableLoad,
      bearingHeight:bearingHeight,
      bottomPlate:bottomPlate,
      webPlate:webPlate,
      ribPlate:ribPlate,
      backPlate:backPlate,
      boltSpace:boltSpace,
      bearingQuality:bearingQuality,
      addQuality:addQuality,
      picUrl:picUrl,
    );
    await _db.insert('tbl_saddleType', saddleTypeModel.toJson());
  }

  // 查询所有数据
  queryAll() async {
    return await _db.query('tbl_saddleType');
  }

  // 条件查询
  conditionalQuery(typeLevel,diameter) async {
    // 字符串要加引号
    return await _db.rawQuery("select * from tbl_saddleType where typeLevel = '" + typeLevel + "' and diameter = " + diameter);
  }

  // 查询数据总数
  queryCount() async {
    return await _db.rawQuery('select count(*) from tbl_saddleType');
  }

  // 删除某一条数据
  deleteData(id) async {
    await _db.delete(
      'tbl_saddleType',
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection (通过 `whereArg` 将狗狗的 id 传递给 `delete` 方法，以防止 SQL 注入)
      whereArgs: [id],
    );
  }

  // 删除所有数据
  deleteAll() async {
    await _db.delete('tbl_saddleType');
  }

}
