import 'package:flutter/material.dart';

class DrawerInfo extends StatefulWidget {
  @override
  _DrawerInfoState createState() => _DrawerInfoState();
}

class _DrawerInfoState extends State<DrawerInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Info MAHAL")
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  InkWell(
                    child: Container(
                    margin: EdgeInsets.only(top:15.0, left: 5.0, right:5.0),
                    width: double.infinity,
                    height: 70.0,
                    color: Colors.grey[200],
                      child: Row(
                        children: [
                          Container(margin: EdgeInsets.only(left:20.0), child: Text("Info")),
                        ],
                      )
                    ),
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Infos()),
                      );
                    }
                  ),
                  InkWell(
                      child: Container(
                      margin: EdgeInsets.all(5.0),
                      width: double.infinity,
                      height: 70.0,
                      color: Colors.grey[200],
                      child: Row(
                        children: [
                          Container(margin: EdgeInsets.only(left:20.0), child: Text("About us")),
                        ],
                      )
                    ),
                  ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Infos extends StatefulWidget {
  @override
  _InfosState createState() => _InfosState();
}

class _InfosState extends State<Infos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Infos"),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(margin: EdgeInsets.only(top: 10.0, right: 10.0) ,child: Text("التنقل بين الصفحات", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),)),
                    Container(child: Text("-الواجهة الرئيسية : ظهور أحدث الإعلانات والإعلانات المفضلة بشكل أوتوماتيكي ودوري.", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("- الأقسام : جميع أقسام الإعلانات موضوعة بشكل منضم وواضح لكل ما تحتاج البحت عنه.", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("-المفظلة: ظهور الإعلانات المفضلة لديك",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("-المحلات , تنقسم الصفحة إلى تلاثة أقسام :", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("*القسم الأول العلوي هو عبارة عن مكان ظهور المحلات المفظلة لديك (التي قمت بمتباعتها)", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("*القسم الثاني هو عبارة عن اقتراحات لمحلات يمكنك متابعتها", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("*القسم الثالث يضهر أحدث الإعلات للمحلات التي تتابعها", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("-الصفحة الشخصية : ظهور صفحة التسجيل لأول مرة", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    //
                    Container(margin: EdgeInsets.only(top: 10.0, right: 10.0) ,child: Text("كيفية التسجيل", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("الدخول للصفحة الشخصيه، اذا كان لديك حساب مسبقا يمكنك إدخال الإيميل او رقم الهاتف بالإضافة لكلمة السر, اذا لم يكن لديك حساب مسبق يمكنك الضغط على 'إنشاء حساب' لتظهر لك صفحة إدخال المعلومات", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    //
                    Container(margin: EdgeInsets.only(top: 10.0, right: 10.0) ,child: Text("إضافة إعلان جديد", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("- الخطوة الأولى : إضافة صور للمنتج أو الإعلان، صورة واحدة على الأقل وأربع صور على الأكثر (يستحسن إضافة كل الصور لظهور الإعلان بشكل جميل وأكثر وضوح).", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("-الخطوة الثانية : اختيار القسم المناسب للإعلان الخاص بك لجعل الوصول إليه بسيط وسريع", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("-الخطوة الثالثة : إدخال معلومات الإعلان من إسم وثمن ووصف معمق يوضح مميزات وخصائص هذا الإعلان بالإضافة إلى إختيار النوع هل جديد أم مستعمل.", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("-الخطوة الرابعة : إضافة الكلمات الدلالية لهذا الإعلان لتسهيل الوصول إليه عند البحث", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    //
                    Container(margin: EdgeInsets.only(top: 10.0, right: 10.0) ,child: Text("التعديل على الإعلان", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("للتعديل على أي منتج أو إعلان تريد يجب عليك تحديده أولا بالدخول إليه والضغط على الثلاث نقاط أعلاه للذهاب لصفحة التعديل", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    //
                    Container(margin: EdgeInsets.only(top: 10.0, right: 10.0) ,child: Text("التعديل على معلومات الحساب الشخصي", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("الدخول للصفحة الشخصية والضغط على زر تعديل المتجر للذهاب لصفحة التعديل أو النقر على النقاط الثلاث أعلى الصفحة", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    //
                    Container(margin: EdgeInsets.only(top: 10.0, right: 10.0) ,child: Text("الإبلاغ عن مخالفة أو غش", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("الدخول للمتجر المراد الإبلاغ عنه والنقر على الثلاث نقاط ثم 'إبلاغ' لتظهر لك نافذة تحدد فيها سبب الإبلاغ ووصف يبرز سبب هذا الإبلاغ", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                    Container(child: Text("")),
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