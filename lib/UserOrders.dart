import 'package:flutter/material.dart';


class UserOrders extends StatefulWidget {
  @override
  UserOrdersState createState() => UserOrdersState();
}

class UserOrdersState extends State<UserOrders> with SingleTickerProviderStateMixin {

TabController controller;

@override
void initState() {
  // TODO: implement initState
  controller = new TabController(length: 2, vsync: this);
  super.initState();
}

@override
Widget build(BuildContext context) {

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'EasyClean',
    theme: ThemeData(),
  home: Scaffold(
    appBar: AppBar(
      title: new Text('EasyClean'),
      backgroundColor: Colors.blueGrey,
      bottom: new TabBar(
        controller: controller,
        tabs: <Widget>[
          new Tab(icon: new Icon(Icons.access_alarm),text: 'Current Orders'),
          new Tab(icon: new Icon(Icons.access_time),text: 'Order History'),


        ],
      ),

    ),

    body: new TabBarView(
      controller: controller,
      children: <Widget>[
        Center(child:new Text('one')),
        Center(child:new Text('two')),
      ],),
  )
  );
}
}

