
import 'package:flutter/material.dart';
import 'Auth.dart';
import 'main.dart';
import 'UserOrders.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ChatPage.dart';


class UserDashboard extends StatefulWidget {

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard>{

  List<int> list = List();


  @override
  Widget build(BuildContext context) {

    return MaterialApp (
      debugShowCheckedModeBanner: false,
      title: 'EasyClean',
      theme: ThemeData.fallback(),
      home: Scaffold(
        appBar: AppBar(title: Text('Chat'),backgroundColor: Colors.blueGrey),
        body:Container(


          child: ChatPage("any"),
        )


            ,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
               accountEmail: Text('shaileshnparkhi@gmail.com',textAlign: TextAlign.center,),
              accountName: Text('User',textAlign: TextAlign.center),
                currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('images/download.jpeg')),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                ),
              ),


              ListTile(
                title: Text('Support'),
                onTap:(){setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text(""),

                        content: new Text("Work in Progess"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
                },
              ),
              ListTile(
                title: Text('FAQ'),
                onTap:(){setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text(""),

                        content: new Text("Work in Progess"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                });
                },
              ),
              ListTile(
                title: Text('Logout'),
                onTap:(){setState(() {

                  Auth().signOut();
                  try{
                    Navigator.pop(context);
                  }catch(r){
                    main();
                  }


                });
                },
              ),
            ],
          ),
          ),



      ),
    );
  }
}











