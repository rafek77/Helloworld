import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;

class NewStore extends StatefulWidget {
  @override
  _NewStoreState createState() => _NewStoreState();
}

class _NewStoreState extends State<NewStore> {
  Future<dynamic> future;
   var idSS;
  String idStore = "9";
  dynamic store;

  void loadStore() {
    String url = 'http://192.168.0.130:8080/Store/${idStore}';
    http.get(url).then((resp) {
      setState(() {
        this.store = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }

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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadStore();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
          child: Scaffold(
        appBar: AppBar(

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(  
                // les Stores 
                child: CarouselSlider(
                  options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      //onPageChanged: callbackFunction,
                      scrollDirection: Axis.horizontal,
                  ),
                  items: [
                    for(var i = 0; i<10; i++)
                    Container(
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            
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
                                  color: Colors.red,
                                  child: Row(
                                    children: [
                                      //image de store
                                      Container(
                                        //alignment: Alignment.topRight,
                                        margin: EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          backgroundColor:
                                          Colors.orange[900],
                                          maxRadius: 30.0,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey,
                                            maxRadius: 28.0,
                                            backgroundImage: 
                                            //store[i]["imageStore"] 
                                            //== null
                                              //  ? 
                                              AssetImage('images/vans.jpg')
                                                //:
                                                  //NetworkImage("http://192.168.0.127:8080/Store/image/${store[i]['idStore']}"),
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
                                            child: Text("name here",
                                              //store[i]['nomstore'],
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
                                    ],
                                  ),
                                ),
                                //partie bas
                                Container(
                                  color: Colors.blue,
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
                                                                  "http://192.168.0.127:8080/Produit/image/${snapshot.data[j]["idProd"]}/1",
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
                                                                "images/vans.jpg",
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
                      )
                    ),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}