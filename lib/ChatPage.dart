import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Auth.dart';

class ChatPage extends StatefulWidget {

  ChatPage(this._userName);

   String _userName;

  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    String asd;

    new Auth().getCurrentUser().then((result){
      asd = result;
      widget._userName = asd;
    });

    double c_width = MediaQuery.of(context).size.width*0.8;
    return new Scaffold(
backgroundColor: Colors.blueGrey[50],
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection("chat_room")
                      .orderBy("created_at", descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return new ListView.builder(
                      padding: new EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) {
                        DocumentSnapshot document =
                        snapshot.data.documents[index];

                        bool isOwnMessage = false;
                        if (document['user_name'] == widget._userName) {
                          isOwnMessage = true;
                        }
                        return isOwnMessage
                            ? _ownMessage(
                            document['message'], document['user_name'])
                            : _message(
                            document['message'], document['user_name']);
                      },
                      itemCount: snapshot.data.documents.length,
                    );
                  },
                ),
              ),
              new Divider(height: 1.0),
              Container(

                margin: EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0),
                child: Row(
                  children: <Widget>[
                    new Flexible(

                      child: new TextField(
                        controller: _controller,
                        onSubmitted: _handleSubmit,
                        decoration:
                        new InputDecoration.collapsed(hintText: "send message",),
                      ),
                    ),
                    new Container(
                      child: new IconButton(
                          icon: new Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            if(_controller.text.length > 0){
                              _handleSubmit(_controller.text);
                            }

                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _ownMessage(String message, String userName) {
    return Row(

      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0),
            ClipRRect(borderRadius: new BorderRadius.circular(8.0),child: Container(
            constraints: BoxConstraints(
            maxWidth: 250,
            minWidth: 20
            ),
            foregroundDecoration: new BoxDecoration(
            border: Border.all(width: 10.0, color: Colors.green),
            shape: BoxShape.rectangle
            ),
            color: Colors.green,
            padding: EdgeInsets.all(10),
            child:
            Column(children: <Widget>[Text(message,style: TextStyle(color: Colors.white),maxLines: 5,),
            ],)
            )),

          ],
        ),
        Icon(Icons.person),
      ],
    );
  }

  Widget _message(String message, String userName) {
    return Row(
      children: <Widget>[
        Icon(Icons.person),
        Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 10.0),
            ClipRRect(borderRadius: new BorderRadius.circular(8.0),child: Container(
                constraints: BoxConstraints(
                    maxWidth: 250,
                    minWidth: 20
                ),
                foregroundDecoration: new BoxDecoration(
                    border: Border.all(width: 10.0, color: Colors.white),
                    shape: BoxShape.rectangle
                ),
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child:
                Column(children: <Widget>[ Text(message,style: TextStyle(color: Colors.black),maxLines: 5,)
                ],)
            )),

          ],
        ),
      ],
    );
  }

  _handleSubmit(String message) {
    if (_controller.text.length > 0){
      _controller.text = "";
      var db = Firestore.instance;
      db.collection("chat_room").add({
        "user_name": widget._userName,
        "message": message,
        "created_at": DateTime.now()
      }).then((val) {
        print("sucess");
      }).catchError((err) {
        print(err);
      });
    }
    }

}