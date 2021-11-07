import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled/tools/appManual.dart';
import 'package:untitled/tools/drawer.dart';
import 'package:untitled/tools/drawerLogOut.dart';

import 'home.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}


class _AboutUsState extends State<AboutUs> {


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(390, 763),

        builder: () => Scaffold(
      backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 69.sp,
              iconTheme: const IconThemeData(color:Colors.grey),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Image.asset('image/logo.jpg', fit: BoxFit.fitHeight, height: 55.h),
              actions: [
                GestureDetector(
                  onTap:() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AppManual()));
                  },
                  child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.015)),
                        Icon(Icons.book_outlined, size: 26.sp),
                        Text('   App\nManual',style: TextStyle(color: Colors.black54, fontSize: 10.sp),)]),),
                Padding(padding:EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.055))],

            ),
        drawer: (FirebaseAuth.instance.currentUser != null)?
        DrawerForAll() : DrawerLogOut(),

        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget> [

                    Padding(
                        padding: EdgeInsets.only(left:10.sp, right:10.sp, top:20.sp),
                        child: Text('  Who We Are', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold ))
                    ),
                    Padding(
                        padding: EdgeInsets.only(left:20.sp, right: 40.sp, top:20.sp),
                        child: Text('    We are a youth organization that strives to connect, communicate, and show gratitude to the Korean War Veterans.',
                            style: TextStyle(fontSize: 20.sp,))
                    ),

                    Padding(
                        padding: EdgeInsets.only(left:10.sp, top: 30.sp, right:10.sp),
                        child: Text('  What We Do', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold,))
                    ),
                    Padding(
                        padding: EdgeInsets.only(left:20.sp, right: 40.sp, top:20.sp),
                        child: Text('    Our goal is to show how current-day Korea has changed since the Korean War. We post videos, write articles, and conduct research on the history of the war to connect with the youth, who do not know much, and to remember the services of the veterans. \n \n    But that is not what we only do. Another goal of ours is to give back to the veterans who have served in the war. There are many of them who are poor and in need of aid. We hope to raise a charity for them to meet their needs and show appreciation for their service. \n \n',
                            style: TextStyle(fontSize: 20.sp, ))
                    ),
                  ]
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(top:20.sp),
                      child: Text('  Contact Us', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold))
                  )
              ),
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),

              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
              child: Row(children: <Widget>[
                Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)),
                Container(
                  height:  200.sp,
                  width: 195.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.4,
                      color: Colors.grey,
                    ),
                  ),
                  child:Column(children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                    Icon(Icons.alternate_email, size: 40.sp),
                  Padding(
                          padding: EdgeInsets.only(),
                          child: Text('Email', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black))
                      ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(top:10),
                          child: Text('22vzkoreanwar\n @gmail.com', style: TextStyle(fontSize: 15.sp,))
                      )
                  ),]),
        ),
                Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)),


                GestureDetector(
                  child: Container(
                  height:  200.sp,
                  width: 195.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.4,
                      color: Colors.grey,
                    ),
                  ),
                  child:Column(children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.1,
                      child:  Image.asset('image/youtube_logo.png', ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(),
                        child: Text('Youtube', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black))
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(top:10.sp),
                            child: Text('22VZ', style: TextStyle(fontSize: 15.sp))
                        )
                    ),]),
                ),),

                Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)),
                Container(
                  height:  200.sp,
                  width: 195.sp,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 0.4,
                      color: Colors.grey,
                    ),
                  ),
                  child:Column(children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width *0.1,
                      child:  Image.asset('image/box.jpg', ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(),
                        child: Text('Address', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black))
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.only(top:10.sp, left: 10.sp),
                            child: Text('603-1701, 158, Seongbok 2-ro, Suji-gu, Yongin-si, Gyeonggi-do, Republic of Korea 16809',
                                style: TextStyle(fontSize: 15.sp,))
                        )
                    ),]),
                ),
                Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.05)),


              ])
              ),
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.04)),
              Text('  Our Team', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02)),

              Row(
                children: <Widget>[

                  Column(children: <Widget>[
                    CircleAvatar(
                        radius: 70.sp,
                        backgroundImage: AssetImage('image/Dongha.jpg')
                    ),
    Text('Dongha Kim', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
                    Text('Founder & App Developer',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                        80, 80, 80, 1.0),) ),
                    Text('829dankim@gmail.com',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                        130, 130, 130, 1.0),height: 2.h) ),
    ]),

                  Column(children: <Widget>[
                    CircleAvatar(
                        radius: 70.sp,
                        backgroundImage: AssetImage('image/Amber.jpg')
                    ),
                    Text('Amber Kim', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
                    Text('Writing Leader',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                        80, 80, 80, 1.0),) ),
                    Text('amberkim2004@gmail.com',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                        130, 130, 130, 1.0),height: 2.h) ),
                  ]),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03)),

              Row(
                  children: <Widget>[
                    Column(children: <Widget>[
                      CircleAvatar(
                          radius: 70.sp,
                          backgroundImage: AssetImage('image/David.jpg')
                      ),
                      Text('David Na', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text('Design Leader',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          80, 80, 80, 1.0),) ),
                      Text('davidnalego@gmail.com',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          130, 130, 130, 1.0),height: 2.h) ),
                    ]),
                    Column(children: <Widget>[
                      CircleAvatar(
                          radius: 70.sp,
                          backgroundImage: AssetImage('image/Andrew.jpg')
                      ),
                      Text('Andrew Sim', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text('History Research Leader',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          80, 80, 80, 1.0),) ),
                      Text('asim20041026@gmail.com',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          130, 130, 130, 1.0),height: 2.h) ),
                    ]),
                  ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.03)),

              Row(
                  children: <Widget>[
                    Column(children: <Widget>[
                      CircleAvatar(
                          radius: 70.sp,
                          backgroundImage: AssetImage('image/ChanPark.jpg')
                      ),
                      Text('Chan Park', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text('Video Leader',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          80, 80, 80, 1.0),) ),
                      Text('inthelabcj@gmail.com',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          130, 130, 130, 1.0),height: 2.h) ),
                    ]),
                    Column(children: <Widget>[
                      CircleAvatar(
                          radius: 70.sp,
                          backgroundImage: AssetImage('image/Joshua.jpg')
                      ),
                      Text('Joshua Kim', style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text('Communication Leader',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          80, 80, 80, 1.0),) ),
                      Text('dydy05288@gmail.com',style: TextStyle(fontSize: 12.sp, color: Color.fromRGBO(
                          130, 130, 130, 1.0),height: 2.h) ),
                    ]),
                  ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1)
              )



            ],
        crossAxisAlignment: CrossAxisAlignment.center,
        ),
    )));
  }
}
