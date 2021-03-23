import 'package:flutter/material.dart';

class ListIndex extends StatefulWidget {
  @override
  _ListIndexState createState() => _ListIndexState();
}

class _ListIndexState extends State<ListIndex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Index"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  for(var i = 0 ; i<10; i++)
                    Container(
                      margin: EdgeInsets.all(5.0),
                      width: double.infinity,
                      height: 70.0,
                      color: Colors.redAccent,
                      child: i == 4 ? 
                      Container(
                        height: 100.0,
                        color: Colors.yellow,
                      ):
                      Center(child: Text("${i+1}")),
                    )
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}