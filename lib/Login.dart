
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Auth.dart';
import 'UserDashboard.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title,this.image,this.auth}) : super(key: key);

  final String title;

  final Image image;
  final BaseAuth auth;
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  String emailErrorText,passwordErrorText;
  var emailController = TextEditingController(),passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.



    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueGrey,

      ),
      body: Container(

          padding: EdgeInsets.fromLTRB(20, 100, 20, 0),

          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:Column(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child:
                TextField(

                  controller: emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1.0),
                      borderRadius: BorderRadius.circular(10),

                    ),
                    enabledBorder:OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black,width: 1.0),
                      borderRadius: BorderRadius.circular(10),

                    ),
                    hintText: 'Email',
                    errorText: emailErrorText,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  enabled: true,
                  style: TextStyle(
                    color: Colors.black,
                    height: 0.2,
                  ),
                  onChanged: (input){
                    setState(() {
                      if (emailController.text.length == 0){
                        emailErrorText = 'email is compulsary';
                      }else{
                        emailErrorText = null;
                      }
                    });

                  },

                ),

              ),

              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 1.0),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  enabledBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 1.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black,width: 1.0),
                    borderRadius: BorderRadius.circular(10),

                  ),
                  hintText: 'Password',
                  errorText: passwordErrorText,
                ),
                keyboardType: TextInputType.text,
                obscureText: true,

                enabled: true,
                onChanged: (input){
                  setState(() {
                    if (passwordController.text.length == 0){
                      passwordErrorText = 'password is compulsary';
                    }else{
                      passwordErrorText = null;
                    }
                  });

                },
                style: TextStyle(
                  color: Colors.black,
                  height: 0.2,
                ),

              ),


              ButtonBar(
                alignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.blueGrey[800],
                    child: Text('Login/SignUp'),
                    textColor: Colors.white,
                    onPressed: (){
                      setState(() {
                        if(emailController.text.length == 0){
                          emailErrorText = 'email is compulsary';
                          return;
                        }else{
                          emailErrorText = null;
                        }
                        if(passwordController.text.length == 0){
                          passwordErrorText = 'password is compulsary';
                          return;

                        }else{
                          passwordErrorText = null;
                        }

                        try{

                          widget.auth.signIn(emailController.text, passwordController.text).catchError((onError){

                            try{
                              widget.auth.signUp(emailController.text, passwordController.text).catchError((onError){
                                PlatformException ec = onError;
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialog(
                                      title: new Text("Error"),

                                      content: new Text(ec.message),
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
                                return;
                              }) .then((result){

                                if(result != null){
                                  print('sign up success $result');
                                  widget.auth.setLoggedIn();
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return UserDashboard();
                                  }));
                                }

                              });
                              passwordController.text = '';
                              emailController.text = '';

                            }catch (e){

                            }

                          }).then((result){

                            if(result != null){
                              print('sign in success $result');
                              passwordController.text = '';
                              emailController.text = '';
                              widget.auth.setLoggedIn();
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return UserDashboard();

                              }));
                            }
                              });


                        }catch(e){

                        }

                      });
                    },

                  ),

                ],
              ),

            ],

          )


      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Details extends StatefulWidget {
  @override
  DetailScreen createState() => DetailScreen();
}

class DetailScreen extends State<Details> with SingleTickerProviderStateMixin {

  List<int> arrays = new List();

  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  String emailErrorText;
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    for(int i = 0;i<50;i++){
      arrays.add(i);
    }
    return Scaffold(
      appBar: AppBar(
        title: new Text('EasyClean'),
      ),


      body: new Column(

        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child:
            TextField(

              controller: emailController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1.0),
                  borderRadius: BorderRadius.circular(10),

                ),
                enabledBorder:OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1.0),
                  borderRadius: BorderRadius.circular(10),

                ),
                hintText: 'Email',
                errorText: emailErrorText,
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: true,
              style: TextStyle(
                color: Colors.black,
                height: 0.2,
              ),
              onChanged: (input){
                setState(() {
                  if (emailController.text.length == 0){
                    emailErrorText = 'email is compulsary';
                  }else{
                    emailErrorText = null;
                  }
                });

              },

            ),

          ),
        ],

      ),
    );
  }
}