import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Login.dart';
import 'Auth.dart';
import 'UserDashboard.dart';
import 'UserOrders.dart';
import 'package:firebase_core/firebase_core.dart';


var auth = Auth();

void main() async{

  bool checkLog = await auth.checkLoggedIn();



  if(checkLog){
    runApp(UserDashboard());
  }else{
    runApp(MyApp());
  }


}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat',
            theme:ThemeData(
              primarySwatch: Colors.blueGrey,
              primaryColor: Colors.black,
            ),
            home:LoginPage(title: 'CredibleChat',image: Image.asset(
                'img/download.jpeg'),auth: new Auth(),
            ),
          );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





  @override
  Widget build(BuildContext context){
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.


    return Scaffold(

      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(image:AssetImage('images/0469.jpg'),fit: BoxFit.cover
          )),
        child:
        Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child:
            Text(
              'Enter you PinCode to see service is available in your area',
              textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child:
            TextField(

              keyboardAppearance: Brightness.light,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1.0),
                  borderRadius: BorderRadius.circular(10),


                ),
                hintText: 'Pin Code',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black,width: 1.0)

                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black,width: 1.0)
                )


              ),
              style: TextStyle(color: Colors.black,height: 0.4),
              enabled: true,
              keyboardType: TextInputType.number,


            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child:
           FlatButton(
             child: Text('Check Availability'),
             color: Colors.blueGrey[800],
             colorBrightness: Brightness.dark,
             onPressed: (){
               print('pressed');
             },
           ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Already a member?'),
                    InkWell(
                      child: Text('Sign In',style: TextStyle(color: Colors.blue),textAlign: TextAlign.center,),
                      onTap: (){

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return LoginPage(title: 'EasyClean',image: Image.asset(
                              'img/download.jpeg'),auth: new Auth(),
                          );


                        }));
                      },
                    ),
                  ],
                ),


          ),
        ],
      ),
      ),


    );
  }
}
