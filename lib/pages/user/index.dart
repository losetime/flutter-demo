import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //屏幕适配组件
import '../../sqlite/sqlite.dart';
import 'package:dio/dio.dart';

class UserIndex extends StatefulWidget {
  @override
  _UserIndex createState() => _UserIndex();
}

class _UserIndex extends State<UserIndex> {
  List saddleTypeData = [];
  SqliteHelper sqliteHelper = SqliteHelper();
  TextEditingController _inputJsonData = TextEditingController();

  @override
  void initState() {
    super.initState();
    //初始化状态
  }

  // 获取数据库状态
  void _getSqliteStatus() async {
    await sqliteHelper.initDB();
    List queryResult = await sqliteHelper.queryCount();
    await sqliteHelper.closeDB();
    String sqliteStatus = '当前共有数据：' + queryResult[0]['count(*)'].toString() + '条';
    await showDeleteConfirmDialog1(sqliteStatus);
  }

  // 获取json数据
  getHttp() async {
    try {
      if(_inputJsonData.text == ''){
        String httpTip = '请求地址不能为空';
        await showDeleteConfirmDialog1(httpTip);
      } else {
        Response response = await Dio().get(_inputJsonData.text);
        setState(() {
          saddleTypeData = response.data['saddleType'];
        });
      }
    } catch (e) {
      await showDeleteConfirmDialog1(e.toString());
    }
  }

  // 导入数据库
  void _importSqliteData() async {
    List queryResult;
    await getHttp();
    if(saddleTypeData.length <= 0) return;
    await sqliteHelper.initDB();
    await sqliteHelper.deleteAll();
    // 查询数据总数
    queryResult = await sqliteHelper.queryCount();
    if(queryResult[0]['count(*)'] <= 0) {
      for(int i=0;i<saddleTypeData.length;i++) {
        await sqliteHelper.addSaddleType(
          saddleTypeData[i]['id'],
          saddleTypeData[i]['typeLevel'],
          saddleTypeData[i]['diameter'],
          saddleTypeData[i]['allowableLoad'],
          saddleTypeData[i]['bearingHeight'],
          json.encode(saddleTypeData[i]['bottomPlate']),
          saddleTypeData[i]['webPlate'],
          json.encode(saddleTypeData[i]['ribPlate']),
          json.encode(saddleTypeData[i]['backPlate']),
          json.encode(saddleTypeData[i]['boltSpace']),
          saddleTypeData[i]['bearingQuality'],
          saddleTypeData[i]['addQuality'],
          saddleTypeData[i]['picUrl']
        );
      }
    }
    queryResult = await sqliteHelper.queryCount();
    await sqliteHelper.closeDB();
    String sqliteQuery = '记录成功，当前共有数据：' + queryResult[0]['count(*)'].toString() + '条';
    await showDeleteConfirmDialog1(sqliteQuery);
  }

  Future<bool> showDeleteConfirmDialog1(tipValue) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text(tipValue),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
      return Container(
        padding: EdgeInsets.only(left:20.0, top:40.0,right:20.0,bottom: 40.0),
        child:Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
              child: Text("数据库状态"),
              onPressed: _getSqliteStatus,
            ),
            TextField(
              controller:_inputJsonData,
              autofocus: false,
              decoration: InputDecoration(
                  hintText: "请输入数据地址",
                  prefixIcon: Icon(Icons.http)
              ),
            ),
            RaisedButton(
              child: Text("导入数据库"),
              onPressed: _importSqliteData,
            ),
          ],
        )
      );
  }
}
