import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //屏幕适配组件
import './panel.dart';
import './saddleType.dart';
import 'package:provider/provider.dart';
import '../../provider/globalProvider.dart';

class HomeIndex extends StatefulWidget {
  @override
  _HomeIndex createState() => _HomeIndex();
}

class _HomeIndex extends State<HomeIndex> {
  PanelController panelController = new PanelController();
  bool showPanel = false;

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = Provider.of<HomeProvider>(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    TabController _tabController;
    BorderRadiusGeometry radius = BorderRadius.only(
        topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0));
    // 把SlidingUpPanel 放到index.dart文件中试试
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('容器支座标准查询', style: TextStyle(fontSize: 18.0)),
                Text(
                  'NB/T 47065-2018',
                  style: TextStyle(fontSize: 12.0),
                )
              ]),
          bottom: TabBar(
            indicatorColor: Color.fromRGBO(255, 255, 255, 1),
            tabs: <Widget>[
              Tab(child: Text('鞍式', style: TextStyle(fontSize: 13.0))),
              Tab(child: Text('腿式', style: TextStyle(fontSize: 13.0))),
              Tab(child: Text('耳式', style: TextStyle(fontSize: 13.0))),
              Tab(child: Text('支撑式', style: TextStyle(fontSize: 13.0))),
              Tab(child: Text('钢性环', style: TextStyle(fontSize: 13.0))),
            ],
            controller: _tabController,
          ),
        ),
        body: SlidingUpPanel(
          controller: panelController,
          borderRadius: radius,
          parallaxOffset: 0,
          // maxHeight:350.0,
          minHeight: 0,
          panel: Container(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Panel(),
          ),
          body: TabBarView(
            children: <Widget>[
              SaddleType(),
              // Center(child: Text('船1111')),
              Center(child: Text('船')),
              Center(child: Text('巴士')),
              Center(child: Text('自行车')),
              Center(child: Text('船')),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          //悬浮按钮
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              showPanel = !showPanel;
            });
            showPanel ? panelController.open() : panelController.close();
          },
          backgroundColor: Color.fromRGBO(41,175,124,1),
          mini:true
        ),
      ),
    );
  }
}
