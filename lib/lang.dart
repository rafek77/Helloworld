import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';


class Lang extends StatefulWidget {
  @override
  _LangState createState() => _LangState();
}

class _LangState extends State<Lang> {
  List<dynamic> listClient;

  void loadClient(){
    String url = 'http://192.168.0.130:8080/Client';
    http.get(url).then((resp) {
      setState(() {
        this.listClient = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }
   dynamic produit;

  void loadProduit() {
    String url = 'http://192.168.0.130:8080/Client/4';
    http.get(url).then((resp) {
      setState(() {
        this.produit = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }
  int listClientlength(){
     if(listClient==null){
        return 0;
     }
     else{
       return listClient.length;
     }
  }

  @override
  void initState() {
    super.initState();
    loadClient();
    listClientlength();
    loadProduit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //for(var i =0; i<listClientlength(); i++)
            
            // Container(
            //   child: CarouselSlider(
            //   options: CarouselOptions(
            //     height: 300,
            //     aspectRatio: 16/9,
            //     viewportFraction: 0.6,
            //     initialPage: 0,
            //     enableInfiniteScroll: true,
            //     reverse: false,
            //     autoPlay: false,
            //     autoPlayInterval: Duration(seconds: 3),
            //     autoPlayAnimationDuration: Duration(milliseconds: 800),
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enlargeCenterPage: true,
            //     scrollDirection: Axis.horizontal,
            //   ),
            //   items: [
            //     for(var i = 0; i<listClientlength(); i++)
            //     Container(
            //       child:Text("${listClient[i]['nomClient']}")
            //     )
            //   ]
            // ))
          ],
        ),
      ),
    );
  }
}