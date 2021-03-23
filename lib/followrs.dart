import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Followrs extends StatefulWidget {
  @override
  _FollowrsState createState() => _FollowrsState();
}

class _FollowrsState extends State<Followrs> {

  List<dynamic> listStore;
  String idStore = "1";

  void loadStore() {
    String url='http://192.168.0.127:8080/Follow/byStore/${idStore}';
    http.get(url).then((resp){
        setState(() {
          this.listStore = json.decode(utf8.decode(resp.bodyBytes));
        });
    }).catchError((err){
        print(err);
    });
  }

  @override
  void initState() {
    super.initState();
    loadStore();
  }

  Container ModelStore(String image, String name, String id){
    return Container(
            margin: EdgeInsets.all(5.0),
            height: 70.0,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                    child: CircleAvatar(
                      maxRadius: 50.0,
                      backgroundImage: NetworkImage(image),
                    ),
                  ),
                ),
                Expanded(
                  flex:1,
                    child: Container(
                    child: Text(name,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                  ),
                ),
                Expanded(
                  flex: 1,
                    child: Container(
                    alignment: Alignment.topLeft,
                    child: Center(
                      child: FlatButton(
                      color: Colors.orange[900],
                      textColor: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        //--
                      },
                        child: Text(
                          "Follow back",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    )
                  ),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      appBar: AppBar(
        title: Center(child: Text("المتابعون", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
          child: this.listStore == null ? Center(child: CircularProgressIndicator())
            :ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                for(var i=0;i<listStore.length;i++)
                Column(
                  children: [
                    ModelStore("http://192.168.0.127:8080/Store/image/${listStore[i]['follower']['idStore']}","${listStore[i]['follower']['nomstore']}","${listStore[i]['follower']['idStore']}"),
                    Divider(),
                  ],
                )
              ]
            ),
          ),
      )
    );
  }
}