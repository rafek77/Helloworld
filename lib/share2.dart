import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class Share2 extends StatefulWidget {
  @override
  _Share2State createState() => _Share2State();
}

class _Share2State extends State<Share2> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("store here")),
        backgroundColor: Colors.orange[900],
        actions: [
          PopupMenuButton(
            onSelected: (result){
              if (result == 0) {
                  
              }
              if (result == 1) {
                Navigator.push( context,  MaterialPageRoute(builder: (context) => Dialogue()),);
              }
            },
            itemBuilder: (context) {
            return [
              PopupMenuItem(child: Text("الاعدادات"), value: 0,),
              PopupMenuItem(child: Text("إبلاغ"), value: 1,),
            ];
            
          }),
        ],
      ),
      body: Center(
        child: Container(
        ),
      ),
    );
  }
}

class Dialogue extends StatefulWidget {
  @override
  _DialogueState createState() => _DialogueState();
  //
}
class Signal {
  String name;
  Signal({this.name});
}

class _DialogueState extends State<Dialogue> {

  TextEditingController cause = new TextEditingController();
  String store = "1";  // li declara
  String storeSignaler = "10";  // li dar defaux
  int group;
  String type;

  Future uploadSignal() async {
    if (group == 1) {
      type = "محتوى غير ملائم";
    } else if (group == 2){
      type = "سلوك أو صور مخلة";
    } else if (group == 3){
      type = "غش أو خداع";
    }else{
      type = "أخرى...";
    }
    http.post(
        'http://192.168.0.130:8080/Signal',

        headers: <String,
            String>{
          'Content-Type':
              'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            "store": {
              "idStore": store
            },
            "storesignaler": {
              "idStore": storeSignaler
            },
            "cause": cause.text,
            "type": type
          }
        )).then((resp) {
          print(resp.statusCode);
          if(resp.statusCode==200){
            setState(() {
              Fluttertoast.showToast(
                msg: "تم إرسال الإبلاغ",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                backgroundColor: Colors.orange[900],
                textColor: Colors.white,
                fontSize: 16.0);
            });                                                          
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
            child: AlertDialog(
            title: Text("تحديد سبب الإبلاغ"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            actions: <Widget>[
                FlatButton(
                  child: const Text('تأكيد'),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).accentColor,
                  onPressed: () {
                  uploadSignal();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('إلغاء'),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Theme.of(context).accentColor,
                onPressed: () {
                  Fluttertoast.showToast(
                  msg: "تم الإلغاء",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: 1,
                                  groupValue: group,
                                  activeColor: Colors.orange,
                                  onChanged: (T) {
                                    print(T);
                                    setState(() {
                                      group = T;
                                    });
                                  }),
                              Text("محتوى غير ملائم"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 2,
                                  groupValue: group,
                                  activeColor: Colors.orange,
                                  onChanged: (T) {
                                    print(T);
                                    setState(() {
                                      group = T;
                                    });
                                  }),
                              Text("سلوك أو صور مخلة"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 3,
                                  groupValue: group,
                                  activeColor: Colors.orange,
                                  onChanged: (T) {
                                    print(T);
                                    setState(() {
                                      group = T;
                                    });
                                  }),
                              Text("غش أو خداع"),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 4,
                                  groupValue: group,
                                  activeColor: Colors.orange,
                                  onChanged: (T) {
                                    print(T);
                                    setState(() {
                                      group = T;
                                    });
                                  }),
                              Text("أخرى..."),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    TextField(
                      autofocus: false,
                      maxLines: 1,
                      controller: cause,
                      style: TextStyle(fontSize: 18),
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        hintText: "أكتب وصف لسبب الإبلاغ...",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}