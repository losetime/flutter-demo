import 'package:flutter/material.dart';  //卡片式主题
import 'package:flutter/cupertino.dart'; //ios式风格
import 'home/index.dart';
import 'user/index.dart';


// 动态组件
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.car_detailed),
      title:Text('主页')
    ),
    BottomNavigationBarItem(
      icon:Icon(CupertinoIcons.person),
      title:Text('我的')
    ),
  ];

  final List<Widget> tabBodies = [
    HomeIndex(),
    UserIndex()
  ];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(244,245,245,1.0),
      bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items:bottomTabs,
        // 点击事件
        onTap:(index){
          setState(() {
            currentIndex = index;
            currentPage = tabBodies[currentIndex];
          });
        }
      ),
      body: IndexedStack(
        index:currentIndex,
        children:tabBodies
      ),
    );
  }
}
