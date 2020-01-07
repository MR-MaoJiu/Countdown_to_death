import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'ClockPage .dart';
class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  DateTime nowtime=DateTime.now();
  DateTime nexttime=DateTime.now();
  int age=0;
  int day=27375;
  int power=100;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _howOrder();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("死亡倒计时",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[IconButton(icon:Icon(Icons.timer,color: Colors.black,),onPressed: (){_showDate();}),],
    ),
    body: Column(children: <Widget>[
      Center(child:ClockPage(),),
      Padding(child:Text("人的一生大概可以活27375天"),padding: EdgeInsets.all(20),),
            Padding(child:Text("您今年$age岁了，您还能活大概$day天",style: TextStyle(fontSize: 20),),padding: EdgeInsets.all(20),),
                  Padding(child:Text("您的电量仅剩：$power%且无法充电",style: TextStyle(fontSize: 20,color: Colors.redAccent),),padding: EdgeInsets.all(20),)
      
    ],),
    );
    
  }

  
_showDate()
{
   showDatePicker(
              context: context,
              initialDate: new DateTime.now(),
              firstDate: new DateTime.now().subtract(new Duration(days: 27375)), // 减 30 天
              lastDate: new DateTime.now(),       // 加 30 天
          ).then((DateTime val) async { 
            nexttime=val; 
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('times',nexttime.toString() );     
            var time =nowtime.difference(nexttime);
            setState(() {
            age=  double.parse((time.inDays/365).toString()).toInt();   
            day=  double.parse((27375-time.inDays).toString()).toInt();
             power=(day/27375*100).toInt();   
               print(age);   
            });
             
             
                  
          }).catchError((err) {
              print(err);
          });
}
_howOrder()
async {
  
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var btime=prefs.getString('times')??"";
    btime==""?Toast.show("点击右上角选择出生日期", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM):nexttime=DateTime.parse(btime);
    
    var time =nowtime.difference(nexttime);
    setState(() {
      age=  double.parse((time.inDays/365).toString()).toInt(); 
      day=  double.parse((27375-time.inDays).toString()).toInt();
        power=(day/27375*100).toInt();        
    print(age);  
    });
}
}