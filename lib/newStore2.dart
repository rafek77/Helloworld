import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NewStore2 extends StatefulWidget {
  final Function goToLogin;
  NewStore2(this.goToLogin);

  @override
  _NewStore2State createState() => _NewStore2State();
}

class _NewStore2State extends State<NewStore2>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<dynamic> store = List<dynamic>();
  List<dynamic> follow = List<dynamic>();

  void loadsStore() async {
    String url = 'http://192.168.0.130:8080/Store';
    //Uri uri = Uri.parse(url);
    http.get(url).then((resp) {
      setState(() {
        this.store = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }

  bool a;
  void loadsFollow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email');
    if (email == null) {
      a = false;
    } else {
      a = true;
    }
    String url = 'http://192.168.0.130:8080/Follow/followersbyemail/${email}';
    //Uri uri = Uri.parse(url);
    http.get(url).then((resp) {
      setState(() {
        this.follow = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }

  // Future getpref(String idF) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   email = prefs.getString('email');
  //   var url = "http://192.168.0.127:8080/Follow/followornot/${email}/${idF}";
  //   var response = await http.get(url);
  //   var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
  //   return responsebody;
  // }

  int listStorelength() {
    if (store == null) {
      return 0;
    } else {
      return store.length;
    }
  }

  int listFollowlength() {
    if (follow == null) {
      return 0;
    } else {
      return follow.length;
    }
  }

  Future<dynamic> future;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    Timer(Duration(milliseconds: 1000), () {
      loadsStore();
      loadsFollow();
    });
  }

  String email;

  String idStore = "idStore";

  List<dynamic> listproduit = List<dynamic>();

  var idSS;

  Future<dynamic> getimageP() async {
    var url = "http://192.168.0.130:8080/Produit/lastP/${idSS}";
    var response = await http.get(url);
    var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
    return responsebody;
  }

  Future countP() async {
    var url = "http://192.168.0.130:8080/Produit/CountByStore/${idSS}";
    var response = await http.get(url);
    var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
    return responsebody;
  }

  Route _createRoute(
    Widget page,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: true,
          titleSpacing: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.search_sharp,
            ),
            onPressed: () {
              //Navigator.of(context).push(_createRoute(SearchPage2()));
            },
          ),
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 10.0),
                child: Text(
                  "متاجر",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(bottom: 5.0, right: 10, top: 5),
                        child: Text(
                          "المحلات المقترحة",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.0),
                        ),
                      ),
                      //-------- list -----------
                      Container(
                          padding: EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: store.length,
                            itemBuilder: (context, i) {
                              idSS = "${store[i][idStore]}";
                              //last3prod();
                              future = getimageP();

                              //print(email);
                              return Card(
                                child: InkWell(
                                  onTap: () {
                                    // print(store[i]['idStore']);
                                    // Navigator.of(context)
                                    //     .push(_createRoute(InfoStore(
                                    //         "${store[i]['idStore']}",
                                    //         "${store[i]['nomstore']}")))
                                    //     .then((value) => setState(() {
                                    //           loadsFollow();
                                    //         }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 3.0),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                    ),
                                    margin: EdgeInsets.only(bottom: 1.0),
                                    child: Column(
                                      children: [
                                        //partie haut
                                        Container(
                                          child: Row(
                                            children: [
                                              //image de store
                                              Container(
                                                alignment: Alignment.topRight,
                                                margin: EdgeInsets.all(5.0),
                                                child: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.orange[900],
                                                  maxRadius: 30.0,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    maxRadius: 28.0,
                                                    backgroundImage: store[i][
                                                                "imageStore"] ==
                                                            null
                                                        ? AssetImage(
                                                            'images/vans.jpg')
                                                        : NetworkImage(
                                                            "http://192.168.0.130:8080/Store/image/${store[i]['idStore']}"),
                                                  ),
                                                ),
                                              ),
                                              // mon & adresse
                                              Column(
                                                children: [
                                                  Container(
                                                    width: 250,
                                                    margin: EdgeInsets.only(
                                                        right: 5.0, left: 5.0),
                                                    child: Text(
                                                      store[i]['nomstore'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign:
                                                          TextAlign.right,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5.0, left: 5.0),
                                                    width: 250,
                                                    child: FutureBuilder(
                                                        future: countP(),
                                                        builder: (BuildContext
                                                                context,
                                                            AsyncSnapshot
                                                                snapshot) {
                                                          switch (snapshot
                                                              .connectionState) {
                                                            case ConnectionState
                                                                .none:
                                                              return Center(
                                                                  child:
                                                                      Text(""));
                                                            case ConnectionState
                                                                .waiting:
                                                            case ConnectionState
                                                                .active:
                                                              return Text("");
                                                            case ConnectionState
                                                                .done:
                                                              if (snapshot
                                                                  .hasError)
                                                                return Center(
                                                                    child: Text(
                                                                        ""));
                                                              if (snapshot
                                                                  .hasData)
                                                                return Text(
                                                                  "عدد المنتجات : " +
                                                                      snapshot
                                                                          .data
                                                                          .toString(),
                                                                  //+count("${store[i]['idStore']}").toString(),
                                                                  maxLines: 1,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .right,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                );
                                                          }
                                                        }),
                                                  ),
                                                ],
                                              ),
                                              // nombre Produit
                                            ],
                                          ),
                                        ),
                                        //partie bas
                                        Container(
                                            height: 110,
                                            child: FutureBuilder(
                                                future: future,
                                                initialData: future,
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  switch (snapshot
                                                      .connectionState) {
                                                    case ConnectionState.none:
                                                      return Center(
                                                          child: Text(
                                                              "Try again"));
                                                    case ConnectionState
                                                        .waiting:
                                                    case ConnectionState.active:
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          valueColor:
                                                              new AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.grey),
                                                          strokeWidth: 1,
                                                        ),
                                                      );
                                                    case ConnectionState.done:
                                                      if (snapshot.hasError)
                                                        return Center(
                                                            child: Text(
                                                                "Check your internet"));
                                                      if (snapshot.hasData) {
                                                        if (snapshot
                                                                .data.length ==
                                                            3) {
                                                          return Row(children: [
                                                            for (var j = 0;
                                                                j <
                                                                    snapshot
                                                                        .data
                                                                        .length;
                                                                j++)
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Container(
                                                                      color: Colors
                                                                          .grey,
                                                                      child: Image.network(
                                                                          "http://192.168.0.130:8080/Produit/image/${snapshot.data[j]["idProd"]}/1",
                                                                          fit: BoxFit
                                                                              .cover))),
                                                          ]);
                                                        }
                                                        if (snapshot
                                                                .data.length ==
                                                            2) {
                                                          return Row(children: [
                                                            for (var j = 0;
                                                                j <
                                                                    snapshot
                                                                        .data
                                                                        .length;
                                                                j++)
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Container(
                                                                      color: Colors
                                                                          .grey,
                                                                      child: Image.network(
                                                                          "http://192.168.0.130:8080/Produit/image/${snapshot.data[j]["idProd"]}/1",
                                                                          fit: BoxFit
                                                                              .cover))),
                                                            Expanded(
                                                                flex: 1,
                                                                child: Container(
                                                                    color: Colors
                                                                        .grey,
                                                                    child: Image.asset(
                                                                        "assets/empty1.jpg",
                                                                        fit: BoxFit
                                                                            .cover))),
                                                          ]);
                                                        }
                                                        if (snapshot
                                                                .data.length ==
                                                            1) {
                                                          return Row(children: [
                                                            for (var j = 0;
                                                                j <
                                                                    snapshot
                                                                        .data
                                                                        .length;
                                                                j++)
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Container(
                                                                      color: Colors
                                                                          .grey,
                                                                      child: Image.network(
                                                                          "http://192.168.0.130:8080/Produit/image/${snapshot.data[j]["idProd"]}/1",
                                                                          fit: BoxFit
                                                                              .cover))),
                                                            for (var i = 0;
                                                                i < 2;
                                                                i++)
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Container(
                                                                      color: Colors
                                                                          .grey,
                                                                      child: Image.asset(
                                                                          "images/vans.jpg",
                                                                          fit: BoxFit
                                                                              .cover))),
                                                          ]);
                                                        }
                                                        if (snapshot
                                                                .data.length ==
                                                            0) {
                                                          return Row(children: [
                                                            for (var i = 0;
                                                                i < 3;
                                                                i++)
                                                              Expanded(
                                                                  flex: 1,
                                                                  child: Container(
                                                                      color: Colors
                                                                          .grey,
                                                                      child: Image.asset(
                                                                          "images/vans.jpg",
                                                                          fit: BoxFit
                                                                              .cover))),
                                                          ]);
                                                        }
                                                      }
                                                  }
                                                })),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                    ]),
                  ),
        ),
      )
                );
        
  
}}