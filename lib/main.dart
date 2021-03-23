import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:testWael/followrs.dart';
import './page_home.dart';
import './samsung.dart';
import './produit.dart';
import './picpub.dart';
import './followrs.dart';
import './share2.dart';
import './store.dart';
import './newStore.dart';
import './modelStore.dart';
import './listIndex.dart';
import './drawer.dart';
import './lang.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new ModelStore(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      image: Image.asset("images/splashscreen1.jpg"),
      loaderColor: Colors.white,
      photoSize: 150.0,
      //imageBackground: Image.asset(""),
      navigateAfterSeconds: Lang(),
    
    );
  }
}

//void main() => runApp(MyApp());
// class MyApp extends StatelessWidget{

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: "test Mobile",
//       home: ListIndex(),
//     );
//   }
// }