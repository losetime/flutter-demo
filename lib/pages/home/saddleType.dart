import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //屏幕适配组件
import 'package:provider/provider.dart';
import '../../provider/globalProvider.dart';

class SaddleType extends StatefulWidget {
  @override
  _SaddleType createState() => _SaddleType();
}

class _SaddleType extends State<SaddleType> {
  HomeProvider provider;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    provider = Provider.of<HomeProvider>(context);
    if (provider.saddleTypeData.isEmpty) {
      return Center(
        child: Text('暂无数据'),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(bottom: 190.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/saddleType/" +
                    provider.saddleTypeData['picUrl'] +
                    ".png"),
              ),
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  3: FixedColumnWidth(150.0),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                  color: Color.fromRGBO(41,175,124,1),
                ),
                children: [
                  TableRow(children: [
                    Text(
                      '公称直径DN',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '允许载荷Q/kN',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '支座高度h',
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('底板'),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(41,175,124,1),
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                                width: 50.0,
                                child: Text('l1', textAlign: TextAlign.center)),
                            SizedBox(
                                width: 50.0,
                                child: Text('b1', textAlign: TextAlign.center)),
                            SizedBox(
                                width: 50.0,
                                child: Text('δ1', textAlign: TextAlign.center))
                          ],
                        )
                      ],
                    ),
                  ]),
                  TableRow(children: [
                    Text(
                      provider.saddleTypeData['diameter'],
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      provider.saddleTypeData['allowableLoad'],
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      provider.saddleTypeData['bearingHeight'],
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                            width: 50.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['bottomPlate'])['l1'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 50.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['bottomPlate'])['b1'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 50.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['bottomPlate'])['δ1'],
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                  ]),
                ],
              ),
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(150.0),
                  2: FixedColumnWidth(150.0),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(
                  color: Color.fromRGBO(41,175,124,1),
                ),
                children: [
                  TableRow(children: [
                    Text(
                      '腹板δ2',
                      textAlign: TextAlign.center,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('板筋'),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(41,175,124,1),
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            SizedBox(
                                width: 37.0,
                                child: Text('l3', textAlign: TextAlign.center)),
                            SizedBox(
                                width: 37.0,
                                child: Text('b2', textAlign: TextAlign.center)),
                            SizedBox(
                                width: 37.0,
                                child: Text('b3', textAlign: TextAlign.center)),
                            SizedBox(
                                width: 37.0,
                                child: Text('δ3', textAlign: TextAlign.center)),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('垫板'),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(41,175,124,1),
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('弧长'),
                            Text('b4'),
                            Text('δ4'),
                            Text('e'),
                          ],
                        )
                      ],
                    )
                  ]),
                  TableRow(children: [
                    Text(
                      provider.saddleTypeData['webPlate'],
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        // SizedBox()
                        SizedBox(
                            width: 37.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['ribPlate'])['l3'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 37.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['ribPlate'])['b2'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 37.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['ribPlate'])['b3'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 37.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['ribPlate'])['δ3'],
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(jsonDecode(
                            provider.saddleTypeData['backPlate'])['arcLength']),
                        Text(jsonDecode(
                            provider.saddleTypeData['backPlate'])['b4']),
                        Text(jsonDecode(
                            provider.saddleTypeData['backPlate'])['δ4']),
                        Text(jsonDecode(
                            provider.saddleTypeData['backPlate'])['e']),
                      ],
                    )
                  ]),
                ],
              ),
              Table(
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(230.0)
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                border: TableBorder.all(color: Color.fromRGBO(41,175,124,1)),
                children: [
                  TableRow(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('螺栓间距'),
                        Container(
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Color.fromRGBO(41,175,124,1),
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text('间距l2'),
                            Text('间距l4'),
                            Text('螺孔d'),
                            Text('螺纹M'),
                            Text('孔长l'),
                          ],
                        )
                      ],
                    ),
                    Text(
                      '支座质量/kg',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'h增加100增加的质量/kg',
                      textAlign: TextAlign.center,
                    ),
                  ]),
                  TableRow(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                            width: 46.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['boltSpace'])['l2'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 46.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['boltSpace'])['l4'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 46.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['boltSpace'])['d'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 46.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['boltSpace'])['M'],
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: 46.0,
                            child: Text(
                              jsonDecode(
                                  provider.saddleTypeData['boltSpace'])['l'],
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                    Text(
                      provider.saddleTypeData['bearingQuality'],
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      provider.saddleTypeData['addQuality'],
                      textAlign: TextAlign.center,
                    ),
                  ]),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

/*
  表格Table的参数说明
  columnWidths：设置每一列的宽度。
  defaultColumnWidth：默认的每一列宽度值，默认情况下均分。
  textDirection：文字方向，一般无需考虑。
  border：表格边框。
  defaultVerticalAlignment：每一个cell的垂直方向的alignment。
  总共包含5种：
  top：被放置在的顶部；
  middle：垂直居中；
  bottom：放置在底部；
  baseline：文本baseline对齐；
  fill：充满整个cell。
  textBaseline：defaultVerticalAlignment为baseline的时候，会用到这个属性。
*/
