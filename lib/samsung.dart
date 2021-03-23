import 'package:flutter/material.dart';

class Samsung extends StatefulWidget{
  State<StatefulWidget> createState(){
    return SamsungState();
  }
}

class SamsungState extends State<Samsung>{

  var mobileList = [
    {
      'name':'jakok',
      'age':'21',
      'job':'developer',
      'sexe':'male',
      'city':'berkane'
    },
    {
      'name':'Rafikk',
      'age':'21',
      'job':'developer',
      'sexe':'male',
      'city':'berkane'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: mobileList.length,
        itemBuilder: (context , i){
          return  Container(
              height: 100,
              width: 120,
              child: Card(
                child: Row(
                  children: <Widget>[
                    Container(child: Text(mobileList[i]['name']),),
                    Container(child: Text(mobileList[i]['age']),),
                    Container(child: Text(mobileList[i]['city']),),
                  ],
                ),
              ),
            );
        
        }

      ),
    );
  }
}