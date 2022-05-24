import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //屏幕适配组件
import 'package:provider/provider.dart';
import '../../provider/globalProvider.dart';
import './menuData.dart';
import '../../sqlite/sqlite.dart';

class Panel extends StatefulWidget {
  @override
  _Panel createState() => _Panel();
}

class _Panel extends State<Panel> {
  @override
  Widget build(BuildContext context) {
    return SaddleTypePanel();
  }
}

class SaddleTypePanel extends StatefulWidget {
  @override
  _SaddleTypePanel createState() => _SaddleTypePanel();
}

class _SaddleTypePanel extends State<SaddleTypePanel> {
  HomeProvider provider;
  List<String> saddleTypeValue = ['轻型', '焊制', 'A', '4', '1000-2000', ''];
  List<List> saddleTypeOptions = List(6);
  List tempMenuData = [];
  int optionsIndex = 0;

  @override
  void initState() {
    tempMenuData = saddleTypeData;
    initFirstMenu();
    setMenuOptions(tempMenuData, '轻型');
    super.initState();
  }

  // 初始化第一个选项栏
  void initFirstMenu() {
    List testOption = [];
    for (int i = 0; i < tempMenuData.length; i++) {
      testOption.add(tempMenuData[i]['nowValue']);
      setState(() {
        saddleTypeOptions[0] = testOption;
      });
    }
  }

  // 递归获取菜单值的公共函数
  void setMenuOptions(sourceData, val) {
    for (int i = 0; i < sourceData.length; i++) {
      List testOption = [];
      var sourceItem = sourceData[i]['child'];
      if (sourceItem == null) {
        // print(sourceData[i]['nowValue']);
      } else {
        if (sourceItem[0] is Map) {
          for (int j = 0; j < sourceItem.length; j++) {
            if (sourceData[i]['nowValue'] == val) {
              if(sourceItem[0] is Map){
                optionsIndex = sourceItem[j]['leave'];
                // saddleTypeOptions[optionsIndex].add(sourceItem[j]['nowValue']);
                testOption.add(sourceItem[j]['nowValue']);
                setState(() {
                  saddleTypeOptions[optionsIndex] = testOption;
                });
              }else {
                setState(() {
                  saddleTypeOptions[sourceData[i]['leave'] + 1] = sourceItem;
                });
              }
              
            }
          }
          setMenuOptions(
              sourceData[i]['child'], saddleTypeOptions[optionsIndex][0]);
        } else {
          if(sourceData[i]['nowValue'] == val){
            setState(() {
              saddleTypeOptions[sourceData[i]['leave'] + 1] = sourceItem;
            });
          }
          
        }
      }
    }
  }

  // 判断层级，并根据选择的值重新生成菜单
  void judgeGrade(sourceData, val, index) {
    for (int i = 0; i < sourceData.length; i++) {
      if (sourceData[i]['leave'] == index) {
        if (sourceData[i]['nowValue'] == val) {
          setMenuOptions(sourceData, val);
        }
      } else {
        judgeGrade(sourceData[i]['child'], val, index);
      }
    }
  }

  // 获取各个菜单的初始值
  void getCurrentValue(sourceData, index) {
    for (int i = index + 1; i < sourceData.length; i++) {
      if (sourceData[i].length != 0) {
        setState(() {
          saddleTypeValue[i] = sourceData[i][0];
        });
      }
    }
  }

  // 点击菜单的回调函数
  void setMenuValue(index, val) {
    setState(() {
      saddleTypeValue[index] = val;
    });
    // index: 当前层级
    judgeGrade(tempMenuData, val, index);
    getCurrentValue(saddleTypeOptions, index);
  }

  // 型式参数1 的回调函数
  void getSaddleType(val) {
    setMenuValue(0, val);
  }

  // 型式参数2 的回调函数
  void getMakeStyle(val) {
    setMenuValue(1, val);
  }

  // 型式参数3 的回调函数
  void getLeave(val) {
    setMenuValue(2, val);
  }

  // 板筋数 的回调函数
  void getStiffener(val) {
    setMenuValue(3, val);
  }

  // 适用公称直径 的回调函数
  void getApplicableDiameter(val) {
    setMenuValue(4, val);
  }

  // 当前公称直径 的回调函数
  void getCurrentDiameter(val) {
    setState(() {
      saddleTypeValue[5] = val;
    });
    getQueryResult(saddleTypeValue[2], val);
  }

  // 获取查询结果
  void getQueryResult(typeLevel,val) async {
    List queryResult;
    SqliteHelper sqliteHelper = SqliteHelper();
    await sqliteHelper.initDB();
    queryResult = await sqliteHelper.conditionalQuery(typeLevel,val);
    await sqliteHelper.closeDB();
    if (queryResult.length <= 0) {
      provider.setSaddleTypeData({});
    } else {
      provider.setSaddleTypeData(queryResult[0]);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    provider = Provider.of<HomeProvider>(context);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('型式参数1'),
                RadioMenu(
                  menulist: saddleTypeOptions[0],
                  initValue: saddleTypeValue[0],
                  menuCallBack: getSaddleType,
                ),
              ],
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('型式参数2'),
                  RadioMenu(
                      menulist: saddleTypeOptions[1],
                      initValue: saddleTypeValue[1],
                      menuCallBack: getMakeStyle),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('型式参数3'),
                  RadioMenu(
                      menulist: saddleTypeOptions[2],
                      initValue: saddleTypeValue[2],
                      menuCallBack: getLeave),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('板筋数'),
                  RadioMenu(
                      menulist: saddleTypeOptions[3],
                      initValue: saddleTypeValue[3],
                      menuCallBack: getStiffener),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('适用公称直径'),
                  RadioMenu(
                      menulist: saddleTypeOptions[4],
                      initValue: saddleTypeValue[4],
                      menuCallBack: getApplicableDiameter),
                ]),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('当前公称直径'),
                  RadioMenu(
                      menulist: saddleTypeOptions[5],
                      initValue: saddleTypeValue[5],
                      menuCallBack: getCurrentDiameter),
                ]),
          ],
        ),
      ),
    );
  }
}

class RadioMenu extends StatefulWidget {
  final menulist;
  final initValue;
  final menuCallBack;
  RadioMenu({Key key, this.menulist, this.initValue, this.menuCallBack})
      : super(key: key);
  @override
  _RadioMenu createState() => _RadioMenu();
}

class _RadioMenu extends State<RadioMenu> {
  @override
  Widget build(BuildContext context) {
    List menuWidget = <Widget>[];
    for (int i = 0; i < widget.menulist.length; i++) {
      menuWidget.add(
        RadioListTile<String>(
          title: Text(widget.menulist[i]),
          value: widget.menulist[i],
          groupValue: widget.initValue,
          onChanged: (value) {
            widget.menuCallBack(value);
          },
        ),
      );
    }
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.start,
      spacing: 0, //主轴上子控件的间距
      runSpacing: 0,
      children: menuWidget,
    );
  }
}
