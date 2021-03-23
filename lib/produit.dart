import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';



class Produit extends StatefulWidget {
  @override
  _ProduitState createState() => _ProduitState();
}

class _ProduitState extends State<Produit> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 400.0,
                  width: double.infinity,
                  child: 
                  new Carousel(
                    autoplay: false,
                    dotColor: Colors.white,
                    dotVerticalPadding: 8.0,
                    dotSize: 5.0,
                    dotSpacing: 15.0,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    boxFit: BoxFit.cover,
                    images: [
                      InkWell(
                        child : Image.asset("images/vans.jpg"),
                        onTap: (){
                          Navigator.push( context,  MaterialPageRoute(builder: (context) => Picpub()),);
                        }
                      ),
                    ],
                  )
                )
              ]
            ))));
  }
}

// picpub -----------------------------------------

class Picpub extends StatefulWidget {
  @override
  _PicpubState createState() => _PicpubState();
}

class _PicpubState extends State<Picpub> {
   bool loading = false;
   final Dio dio = Dio();
   double progress = 0.0;
   String idP = "9";
   
  dynamic produit;

  void loadProduit() {
    String url = 'http://192.168.0.130:8080/Produit/${idP}';
    http.get(url).then((resp) {
      setState(() {
        this.produit = json.decode(utf8.decode(resp.bodyBytes));
      });
    }).catchError((err) {
      print(err);
    });
  }

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try{
      // Android --
      if(Platform.isAndroid){
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
          
          String newPath ="";
          List<String> folders = directory.path.split("/");
          for(var x = 1; x<folders.length; x++){
            String folder = folders[x];
            if(folder != "Android"){
              newPath += "/"+ folder;
            }else{
              break;
            }
          }
          newPath = newPath+"/JotiaApp";
          directory = Directory(newPath);
          print(directory.path);
        }else{
          return false;
        }
      }
      //IOS
      else{
        if(await _requestPermission(Permission.photos)){
          directory = await getTemporaryDirectory();
        }else{  
          return false;
        }
      }

      if(!await directory.exists()){
        await directory.create(recursive: true);
      }
      if(await directory.exists()){
        File saveFile = File(directory.path+"/$fileName"); 
        await dio.download(url, saveFile.path, onReceiveProgress: (downloaded,totalSize){
          setState((){
            progress = downloaded/totalSize;
          });
        });
        if(Platform.isIOS){
          await ImageGallerySaver.saveFile(saveFile.path,isReturnPathOfIOS: true);
        }
        return true;
      }
    }catch(e){
      print(e);
    }
    return false;
  }

  //permission 
  Future<bool>_requestPermission(Permission permission) async {
     if(await permission.isGranted){
      return true;
    }else{
      var result = await permission.request();
      if(result == PermissionStatus.granted){
        return true;
      }else{
        return false;
      }
    }
  }


  //main methode
  downloadFile() async{
    setState(() {
      loading = true;
    });

    bool downloaded = await saveFile("http://192.168.0.130:8080/Produit/image/${idP}/1", "picture1${idP}.jpg");

    if(downloaded){
      print("File Downloaded");
    }else{
      print("Problem Downloaded");
    }

    setState(() {
      loading = false;
    });
  }
  // 2
  downloadFile2() async{
    setState(() {
      loading = true;
    });

    bool downloaded = await saveFile("http://192.168.0.130:8080/Produit/image/${idP}/2", "picture2${idP}.jpg");

    if(downloaded){
      print("File Downloaded");
    }else{
      print("Problem Downloaded");
    }

    setState(() {
      loading = false;
    });
  }
  //3
  downloadFile3() async{
    setState(() {
      loading = true;
    });

    bool downloaded = await saveFile("http://192.168.0.130:8080/Produit/image/${idP}/3", "picture3${idP}.jpg");

    if(downloaded){
      print("File Downloaded");
    }else{
      print("Problem Downloaded");
    }

    setState(() {
      loading = false;
    });
  }
   //4
  downloadFile4() async{
    setState(() {
      loading = true;
    });

    bool downloaded = await saveFile("http://192.168.0.130:8080/Produit/image/${idP}/4", "picture4${idP}.jpg");

    if(downloaded){
      print("File Downloaded");
    }else{
      print("Problem Downloaded");
    }

    setState(() {
      loading = false;
    });
  }

  downloadFile5() async{
    
  }

  @override
  void initState() {
    super.initState();
    loadProduit();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
            child: InteractiveViewer(
              minScale: 0.2,
              maxScale: 50.0,
                child: Container(
                  child: Carousel(
                    autoplay: false,
                    dotColor: Colors.white,
                    dotVerticalPadding: 8.0,
                    dotSize: 5.0,
                    dotSpacing: 15.0,
                    indicatorBgPadding: 5.0,
                    dotBgColor: Colors.transparent,
                    boxFit: BoxFit.cover,
                    images: [
                      for(var i = 1; i<3+1;i++)
                      Stack(
                        children: [
                          Center(child: Container(child: Image.network('http://192.168.0.130:8080/Produit/image/${idP}/${i}'), )),
                          Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Container(
                                    padding:EdgeInsets.only( right: 10,top: 25),
                                    child: Icon(Icons.save, color: Colors.white,)
                              ),
                              onTap: (){
                               setState(() {
                                 // ignore: unnecessary_statements
                                 downloadFile()+"$i";
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      // //image 2
                      // Stack(
                      //   children: [
                      //     Center(child: Container(child: Image.network('http://192.168.0.130:8080/Produit/image/${idP}/2'), )),
                      //     Align(
                      //       alignment: Alignment.topRight,
                      //       child: InkWell(
                      //           child: Container(
                      //               padding:EdgeInsets.only( right: 10,top: 25),
                      //               child: Icon(Icons.save, color: Colors.white,)
                      //         ),
                      //         onTap: (){
                      //           setState(() {
                      //            downloadFile2();
                      //           });
                      //         },
                      //     ),
                      //     ),
                      //   ],
                      
                      // ),
                      // //image 3
                      // Stack(
                      //   children: [
                      //     Center(child: Container(child: Image.network('http://192.168.0.130:8080/Produit/image/${idP}/3'), )),
                      //     Align(
                      //       alignment: Alignment.topRight,
                      //       child: InkWell(
                      //           child: Container(
                      //               padding:EdgeInsets.only( right: 10,top: 25),
                      //               child: Icon(Icons.save, color: Colors.white,)
                      //         ),
                      //         onTap: (){
                      //           setState(() {
                      //            downloadFile3();
                      //           });
                      //         },
                      //     ),
                      //     ),
                      //   ],
                      // ),
                      // //image 4
                      // Stack(
                      //   children: [
                      //     Center(child: Container(child: Image.network('http://192.168.0.130:8080/Produit/image/${idP}/4'), )),
                      //     Align(
                      //       alignment: Alignment.topRight,
                      //       child: InkWell(
                      //           child: Container(
                      //               padding:EdgeInsets.only( right: 10,top: 25),
                      //               child: Icon(Icons.save, color: Colors.white,)
                      //         ),
                      //         onTap: (){
                      //           setState(() {
                      //            downloadFile3();
                      //           });
                      //         },
                      //     ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  )
                ), 
            ),
          )
      ),
    );
  }
}