import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:readmore/readmore.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  bool a = false;
  String emaill = "raf.jako@77g.com";

  bool afficher() {
    if (emaill != "") {
      return a = true;
    }
  }

  Future getdata() async {
    var url = "http://192.168.0.130:8080/Store";
    var response = await http.get(url);
    var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
    return responsebody;
  }

  //
  var idSS;
  Future getimageP() async {
    var url = "http://192.168.0.130:8080/Produit/lastP/${idSS}";
    var response = await http.get(url);
    var responsebody = jsonDecode(utf8.decode(response.bodyBytes));
    return responsebody;
  }

  List<dynamic> listStore;
  String idStore = "1";

  void loadStore() {
    String url = 'http://192.168.0.130:8080/Store';
    http.get(url).then((resp) {
      setState(() {
        this.listStore = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }

  List<dynamic> listProduit;
  String idProd = "1";

  void loadProduit() {
    String url = 'http://192.168.0.130:8080/Produit';
    http.get(url).then((resp) {
      setState(() {
        this.listProduit = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }

  Container StoreModel(String imageStore, String nomStore, String imageP, String prix, String nomP, String desc) {
    return Container(
      child: Stack(children: [
        Container(
            margin: EdgeInsets.only(bottom: 3.0),
            height: 550.0,
            child: Column(
              children: [
                //info Store 
                Container(
                  child: Row(
                    children: [
                      //image de store
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.all(5.0),
                          child: CircleAvatar(
                            maxRadius: 30.0,
                            backgroundImage: NetworkImage(
                              imageStore,
                            ),
                          ),
                        ),
                      ),
                      // mon
                      Expanded(
                        flex: 5,
                        child: Container(
                          //alignment: Alignment.topRight,
                          margin: EdgeInsets.only(right: 5.0, top: 5.0, bottom: 5.0),
                          width: 150,
                          child: Container(
                            alignment: Alignment.topRight,
                            margin: EdgeInsets.all(5.0),
                            child: Text(
                              nomStore,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //image de produit
                InteractiveViewer(
                  minScale: 0.1,
                  maxScale: 1.5,
                  child: Container(
                      height: 350,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(imageP),
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                //info de Produit
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 12.0, right: 5.0, left: 5.0),
                        child: Row(
                          children: [
                            //nom Produit
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Text(
                                  nomP,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            //favorite
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Icon(Icons.favorite_border),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // description
                      Container(
                        alignment: Alignment.centerRight,
                        height: 80,
                        child: ReadMoreText(
                          desc,
                          trimLines: 2,
                          colorClickableText: Colors.pink,
                          trimMode: TrimMode.Line,
                          delimiter: "",
                          trimCollapsedText: '...  أظهر المزيد',
                          trimExpandedText: '',
                          moreStyle: TextStyle( fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            //Prix Produit
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 397.0),
                decoration: BoxDecoration(
                  color: Colors.orange[900],
                  borderRadius: BorderRadius.all(
                    Radius.circular(400.0),
                  ),
                ),
                child: Text(prix, style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
            ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    afficher();
    loadStore();
    loadProduit();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: [
            InkWell(
              child: Icon(Icons.search),
            )
          ],
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              // Store don't exist ------------------------------------------
              // Login message here
              Container(
                height: 160.0,
                width: double.infinity,
                child: a == false
                    ? Center(
                        child: Column(
                        children: [
                          // -----------------
                          Container(
                              padding: EdgeInsets.only(top: 30.0),
                              child: Text(
                                " لست مسجل بعد, قم بالتسجيل.",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              )),
                          Container(
                            child: RaisedButton(
                              color: Colors.orange[900],
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              child: Text(
                                "التسجيل",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0),
                              ),
                            ),
                          ),
                        ],
                      ))
                    :
                    // Store exist here --------------------------------------------------
                    Container(
                        height: 160.0,
                        width: double.infinity,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topRight,
                              margin: EdgeInsets.only(
                                bottom: 10.0,
                                right: 10.0,
                              ),
                              child: Text(
                                "المحلات المفظلة",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              height: 120,
                              padding: EdgeInsets.only(right: 8.0),
                              child: FutureBuilder(
                                  future: getdata(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: snapshot.data.length,
                                        itemBuilder: (context, i) {
                                          return InkWell(
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: CircleAvatar(
                                                      maxRadius: 40.0,
                                                      backgroundImage: NetworkImage(
                                                          "http://192.168.0.130:8080/Store/image/${snapshot.data[i]['idStore']}"),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 100,
                                                    margin: EdgeInsets.only(
                                                        top: 5.0),
                                                    child: Center(
                                                      child: Flexible(
                                                        child: RichText(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          strutStyle:
                                                              StrutStyle(
                                                                  fontSize:
                                                                      5.0),
                                                          text: TextSpan(
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            text: snapshot
                                                                    .data[i]
                                                                ['nomstore'],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }),
                            ),
                            //
                          ],
                        ),
                      ),
              ),
              //----------------------------------------------------------------------------------------------
              //les stores recommander
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(bottom: 5.0, right: 10, top: 5),
                child: Text(
                  "المحلات المقترحة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              //-------- list -----------
              Container(
                height: 200.0,
                child: FutureBuilder(
                  future: getdata(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          idSS = "${snapshot.data[i]['idStore']}";
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('infostore');
                            },
                            child: Container(
                              width: 250.0,
                              margin: EdgeInsets.only(left: 5.0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 3.0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  //partie haut
                                  Container(
                                    color: Colors.black,
                                    child: Row(
                                      children: [
                                        //image de store
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.all(5.0),
                                            child: CircleAvatar(
                                              maxRadius: 30.0,
                                              backgroundImage: NetworkImage(
                                                  "http://192.168.0.130:8080/Store/image/${snapshot.data[i]['idStore']}"),
                                            ),
                                          ),
                                        ),
                                        // mon & adresse
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                right: 5.0,
                                                top: 5.0,
                                                bottom: 5.0),
                                            width: 150,
                                            child: Column(
                                              children: [
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  margin: EdgeInsets.all(5.0),
                                                  child: Text(
                                                    snapshot.data[i]
                                                        ['nomstore'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.topRight,
                                                  margin: EdgeInsets.all(5.0),
                                                  child: Text(
                                                      "عدد المنتجات : 25",
                                                      //snapshot.data[i]['email'],maxLines: 2,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //partie bas
                                  Container(
                                      height: 80,
                                      child: FutureBuilder(
                                          future: getimageP(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                                return Center(
                                                    child: Text("Try again"));
                                              case ConnectionState.waiting:
                                              case ConnectionState.active:
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              case ConnectionState.done:
                                                if (snapshot.hasError)
                                                  return Center(
                                                      child: Text(
                                                          "Check your internet"));
                                                if (snapshot.hasData) {
                                                  if (snapshot.data.length ==
                                                      3) {
                                                    return Row(children: [
                                                      for (var j = 0;
                                                          j <
                                                              snapshot
                                                                  .data.length;
                                                          j++)
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                color:
                                                                    Colors.grey,
                                                                child: Image.network(
                                                                    "http://192.168.0.130:8080/Produit/image/${snapshot.data[j]["idProd"]}/1",
                                                                    fit: BoxFit
                                                                        .cover))),
                                                    ]);
                                                  }
                                                  if (snapshot.data.length ==
                                                      2) {
                                                    return Row(children: [
                                                      for (var j = 0;
                                                          j <
                                                              snapshot
                                                                  .data.length;
                                                          j++)
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                color:
                                                                    Colors.grey,
                                                                child: Image.network(
                                                                    "http://192.168.0.130:8080/Produit/image/${snapshot.data[j]["idProd"]}/1",
                                                                    fit: BoxFit
                                                                        .cover))),
                                                      Expanded(
                                                          flex: 1,
                                                          child: Container(
                                                              color:
                                                                  Colors.grey,
                                                              child: Image.asset(
                                                                  "images/empty1.jpg",
                                                                  fit: BoxFit
                                                                      .cover))),
                                                    ]);
                                                  }
                                                  if (snapshot.data.length ==
                                                      1) {
                                                    return Row(children: [
                                                      for (var j = 0;
                                                          j <
                                                              snapshot
                                                                  .data.length;
                                                          j++)
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                color:
                                                                    Colors.grey,
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
                                                                color:
                                                                    Colors.grey,
                                                                child: Image.asset(
                                                                    "images/empty1.jpg",
                                                                    fit: BoxFit
                                                                        .cover))),
                                                    ]);
                                                  }
                                                  if (snapshot.data.length ==
                                                      0) {
                                                    return Row(children: [
                                                      for (var i = 0;
                                                          i < 3;
                                                          i++)
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                color:
                                                                    Colors.grey,
                                                                child: Image.asset(
                                                                    "images/empty1.jpg",
                                                                    fit: BoxFit
                                                                        .cover))),
                                                    ]);
                                                  }
                                                }
                                            }
                                          })),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: 2.0, right: 2.0, left: 2.0),
                                    height: 42,
                                    width: double.infinity,
                                    color: Colors.black,
                                    child: FlatButton(
                                      color: Colors.orange[900],
                                      textColor: Colors.white,
                                      padding: EdgeInsets.all(8.0),
                                      onPressed: () {
                                        //--
                                      },
                                      child: Text(
                                        "Follow",
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              //Les posts --------------------------------------------------------------------
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(bottom: 5.0, right: 10, top: 5),
                child: Text(
                  "أحدث الإعلانات",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              // -------------------------------------------------------------------------------
              Container(
                  child: this.listStore == null
                      ? Center(child: CircularProgressIndicator())
                      : ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                              for (var i = listProduit.length - 1; i >= 0; i--)
                                StoreModel(
                                    "http://192.168.0.130:8080/Store/image/${listProduit[i]['store']['idStore']}",
                                    "${listProduit[i]['store']['nomstore']}",
                                    "http://192.168.0.130:8080/Produit/image/${listProduit[i]['idProd']}/1",
                                    "${listProduit[i]['prixProd']} MAD ",
                                    "${listProduit[i]['nomProd']}",
                                    "${listProduit[i]['descprod']}"),
                            ]))
            ]),
          ),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(),
    );
  }
}
