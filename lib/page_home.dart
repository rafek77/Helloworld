import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){}),
          ],
          centerTitle: true,
          elevation: 30.0,//shadow
          //leading: IconButton(icon: Icon(Icons.search), onPressed: (){}),
          //titleSpacing: 30.0,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Rafik JAKOK"),
                accountEmail: Text("jakof707@gmail.com"),
                currentAccountPicture: CircleAvatar(child: Icon(Icons.person)),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/space.jpg"), fit: BoxFit.cover),
                ),
              ),
              ListTile(
                title: Text('home', style: TextStyle(color: Colors.black )),
                leading: Icon(Icons.home,  color: Colors.red),
                // trailing: Icon(Icons.arrow_left),
                // subtitle: Text("go at home"),
                // isThreeLine: true,
                onTap: (){},
              ),
              Divider(
                color: Colors.red
              ),
              ListTile(
                title: Text('Categories', style: TextStyle(color: Colors.black ),),
                leading: Icon(Icons.category , color: Colors.red),
                onTap: (){},
              ),
              Divider(
                color: Colors.red
              ),
              ListTile(
                title: Text('About', style: TextStyle(color: Colors.black ),),
                leading: Icon(Icons.question_answer , color: Colors.red),
                onTap: (){},
              ),
              Divider(
                color: Colors.red
              ),
              ListTile(
                title: Text('Settings', style: TextStyle(color: Colors.black ),),
                leading: Icon(Icons.settings , color: Colors.red),
                onTap: (){},
              ),
              Divider(
                color: Colors.red
              ),
              ListTile(
                title: Text('Log Out', style: TextStyle(color: Colors.black ),),
                leading: Icon(Icons.logout , color: Colors.red),
                onTap: (){},
              ),
            ]
          ),
        ),
        body: ListView(
          children: <Widget>[
              Container(
              height: 300.0,
              width: double.infinity,
              child: Carousel(
                dotBgColor: Colors.red.withOpacity(0.3),
                showIndicator: true,
                boxFit: BoxFit.cover,
                overlayShadow: true,
                overlayShadowColors: Colors.red,
                images: [
                  AssetImage("images/vans.jpg"),
                  AssetImage("images/iphone.jpg"),
                  AssetImage("images/adidas.jpg"),
                ],
              ),
            ),
            // ----------- categories --------------------------------------
            Container(
              margin: EdgeInsets.only(top:20, right: 10),
              child: Text("Categories" , style: TextStyle(fontSize: 30 , color: Colors.red),),
            ),
            Container(
              height: 150, 
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 120,
                    width: 120,
                    child: ListTile(
                      title: Image.asset("images/charger.jpg", width: 80, height: 80),
                      subtitle: Container(child:Text("Samsung", textAlign:TextAlign.center )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 120,
                    width: 120,
                    child: ListTile(
                      title: Image.asset("images/charger.jpg", width: 80, height: 80),
                      subtitle: Container(child:Text("Samsung", textAlign:TextAlign.center )),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top:20),
                    height: 120,
                    width: 120,
                    child: ListTile(
                      title: Image.asset("images/charger.jpg", width: 80, height: 80),
                      subtitle: Container(child:Text("Samsung", textAlign:TextAlign.center )),
                    ),
                  ),
                  
                ],
              ),
            ),
            // ------------- New products
            Container(
              margin: EdgeInsets.only(top:10, right: 10),
              child: Text("New Products" , style: TextStyle(fontSize: 30 , color: Colors.red),),
            ),
            Container(
              height: 400,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                children: <Widget>[
                  GridTile(
                    child: Image.asset("images/adidas.jpg"),
                    footer: Container(height: 20, color: Colors.red.withOpacity(0.5), child: Text("Adidas Shoes", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),),
                  ),
                  GridTile(
                    child: Image.asset("images/vans.jpg"),
                    footer: Container(height: 20, color: Colors.red.withOpacity(0.5), child: Text("Adidas Shoes", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),),
                  ),
                  GridTile(
                    child: Image.asset("images/adidas.jpg"),
                    footer: Container(height: 20, color: Colors.red.withOpacity(0.5), child: Text("Adidas Shoes", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),),
                  ),
                  GridTile(
                    child: Image.asset("images/adidas.jpg"),
                    footer: Container(height: 20, color: Colors.red.withOpacity(0.5), child: Text("Adidas Shoes", style: TextStyle(color: Colors.white), textAlign: TextAlign.center),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      );
  }
}