import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';


class ModelStore extends StatefulWidget {
  @override
  _ModelStoreState createState() => _ModelStoreState();
}

class _ModelStoreState extends State<ModelStore> {

  List<dynamic> listStore;

  void loadStore() {
    String url = 'http://192.168.0.127:8080/Store';
    http.get(url).then((resp) {
      setState(() {
        this.listStore = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }

  int listStorelength(){
     if(listStore==null){
        return 0;
     }
     else{
       return listStore.length;
     }
  }

  @override
  void initState() {
    super.initState();
    loadStore();
    listStorelength();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model Store"),
      ),
      body:Container(
        child: CarouselSlider(
          options: CarouselOptions(
            height: 300,
            aspectRatio: 16/9,
            viewportFraction: 0.6,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: [
            for(var i = 0; i<listStorelength(); i++)
              Container(
                child: SingleChildScrollView(
                child: Container(
                width: 230.0,
                height: 290.0,
                  child: Column(
                    children: [
                      //image Store
                      Container(
                        margin: EdgeInsets.only(top:5.0,),
                        child: CircleAvatar(
                          maxRadius: 40.0,
                          backgroundImage: NetworkImage(
                            "http://192.168.0.127:8080/Store/image/${listStore[i]['idStore']}",
                          ),
                        ),
                      ),
                      //name Store
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top:15.0,),
                          child: Text("${listStore[i]['nomstore']}",maxLines: 1 ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        ),
                      ),
                      //nbr Produit
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top:2.0,),
                          child: Text("عدد المنتجات: 07", maxLines: 1 ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      //images Produits
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top:15.0,),
                          child: Row(
                            children: [
                              //produit 2
                              Expanded(
                                flex: 1,
                                child: "http://192.168.0.127:8080/Store/${listStore[i]['p2']}" == null ?
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 75,
                                    width: 50,
                                    color: Colors.grey[200],
                                  ),
                                ):
                                Expanded(
                                  flex: 1,
                                    child: Container(
                                    height: 75,
                                    width: 50,
                                    color: Colors.grey[200],
                                    child: Image.network("http://192.168.0.127:8080/Produit/image/${listStore[i]['p2']}/1", fit: BoxFit.cover,)
                                  ),
                                )
                              ),
                              //produit 1
                              Expanded(
                                flex: 1,
                                child: "http://192.168.0.127:8080/Store/${listStore[i]['p1']}" == null ?
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 75,
                                    width: 50,
                                    color: Colors.grey[200],
                                  ),
                                ):
                                Expanded(
                                  flex: 1,
                                    child: Container(
                                    height: 75,
                                    width: 50,
                                    color: Colors.grey[200],
                                    child: Image.network("http://192.168.0.127:8080/Produit/image/${listStore[i]['p1']}/1", fit: BoxFit.cover,)
                                  ),
                                )
                              ),
                              //produit 3
                              Expanded(
                                flex: 1,
                                child: "http://192.168.0.127:8080/Store/${listStore[i]['p3']}" == null ?
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 75,
                                    width: 50,
                                    color: Colors.grey[200],
                                  ),
                                ):
                                Expanded(
                                  flex: 1,
                                    child: Container(
                                    height: 75,
                                    width: 50,
                                    color: Colors.grey[200],
                                    child: Image.network("http://192.168.0.127:8080/Produit/image/${listStore[i]['p3']}/1", fit: BoxFit.cover,)
                                  ),
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                      //btn Follow
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        height: 30.0,
                        width: 100.0,
                        color: Colors.black,
                        child: FlatButton(
                          color: Colors.orange[900],
                          textColor: Colors.white,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
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
              ),
            ),
          ]
        ),
      ),
    );
  }
}