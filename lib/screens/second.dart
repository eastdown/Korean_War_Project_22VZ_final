import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);

@override
Widget build(BuildContext context) {
  return MaterialApp(
    home: First(),
  );
}
}

/// This is the stateless widget that the main application instantiates.
class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

@override
_firstState createState() => _firstState();
}

class _firstState extends State<First>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TabBar(
            labelStyle: TextStyle(fontSize:15, fontWeight: FontWeight.bold),
            labelColor: Colors.black,
            tabs: [
              Tab(text: "About us"),
              Tab(text: "Leadership"),
              Tab(text: "Contact"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Scaffold(
              body: SingleChildScrollView(
            child: ConstrainedBox(
            constraints: BoxConstraints(),
        child: Column(
                children: <Widget> [

                  Padding(
                      padding: EdgeInsets.only(left:10, right:10, top:20),
                      child: Text('Who We Are', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold', ))
                  ),
                  Padding(
                      padding: EdgeInsets.only(left:20, right: 40, top:20),
                      child: Text('    We are a youth organization that strives to connect, communicate, and show gratitude to the Korean War Veterans.',
                          style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular'))
                  ),

                  Padding(
                      padding: EdgeInsets.only(left:10, top: 30, right:10),
                      child: Text('What We Do', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold',))
                  ),
                  Padding(
                      padding: EdgeInsets.only(left:20, right: 40, top:20),
                      child: Text('    Our goal is to show how current-day Korea has changed since the Korean War. We post videos, write articles, and conduct research on the history of the war to connect with the youth, who do not know much, and to remember the services of the veterans. \n \n    But that is not what we only do. Another goal of ours is to give back to the veterans who have served in the war. There are many of them who are poor and in need of aid. We hope to raise a charity for them to meet their needs and show appreciation for their service. \n \n    But that is not what we only do. Another goal of ours is to give back to the veterans who have served in the war. There are many of them who are poor and in need of aid. We hope to raise a charity for them to meet their needs and show appreciation for their service.',
                          style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular'))
                  ),
                  /*Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left:10, top: 30),
                      child: Text('Purpose', style: TextStyle(fontSize: 50, fontFamily: 'MontserratExtraBold'))
                  ),),

                  Padding(
                      padding: EdgeInsets.only(left:20, right: 40),
                      child: Text('',
                          style: TextStyle(fontSize: 25, fontFamily: 'NotoSerif'))
                  ),*/
                ]
              ),),)
            ),


            Scaffold(
    body:  SingleChildScrollView(
    child: Column(

    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child:Padding(
        padding: EdgeInsets.only(bottom: 20, top:10, left: 10),
        child: Text(
        'Leadership',
        style: TextStyle(fontSize: 50, fontFamily:'MontserratExtraBold'),
      ),),),

    SizedBox(
    height: 400.0,
    child: ListView(
    physics: ClampingScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    children: <Widget> [
      Card(
        semanticContainer: true,
        child: Stack(
            children: <Widget>[
              Image.asset('image/Dongha.jpg'),
              Padding(padding: EdgeInsets.only(left:20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom:300),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Dongha Kim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                            shadows: <Shadow>[

                              Shadow(
                                offset: Offset(0, 0),
                                blurRadius: 15.0,
                                color: Color.fromRGBO(0, 0, 70, 0.8),
                              ),
                            ],)),),


                        Text('App Leader/Founder', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                          shadows: <Shadow>[

                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 15.0,
                              color: Color.fromRGBO(0, 0, 70, 0.8),
                            ),
                          ],)
                        ),
                      ]
                  ))
            ]
        ),),

      Card(
    semanticContainer: true,
    child: Stack(
        children: <Widget>[
          Image.asset('image/Amber.jpg'),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom:300),
              ),
              Padding(
                padding: EdgeInsets.only(left:20),
                  child: Text('Amber Kim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                      shadows: <Shadow>[

                Shadow(
                  offset: Offset(0, 0),
                  blurRadius: 15.0,
                  color: Color.fromRGBO(0, 0, 70, 0.8),
                ),
                ],))
              ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text('Writing Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                  shadows: <Shadow>[

                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 15.0,
                      color: Color.fromRGBO(0, 0, 70, 0.8),
                    ),
                  ],)
              ),
              )
            ]
          )
        ]
        ),),

      Card(
        semanticContainer: true,
        child: Stack(
            children: <Widget>[
              Image.asset('image/Joshua.jpg'),
              Padding(padding: EdgeInsets.only(left:20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom:300),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Joshua Kim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                            shadows: <Shadow>[

                              Shadow(
                                offset: Offset(0, 0),
                                blurRadius: 15.0,
                                color: Color.fromRGBO(0, 0, 70, 0.8),
                              ),
                            ],)),),


                        Text('Communication Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                          shadows: <Shadow>[

                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 15.0,
                              color: Color.fromRGBO(0, 0, 70, 0.8),
                            ),
                          ],)
                        ),
                      ]
                  ))
            ]
        ),),

      Card(
        semanticContainer: true,
        child: Stack(
            children: <Widget>[
              Image.asset('image/ChanPark.jpg'),
              Padding(padding: EdgeInsets.only(left:20),
              child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom:300),
                    ),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Chan Park', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                      shadows: <Shadow>[

                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 15.0,
                          color: Color.fromRGBO(0, 0, 70, 0.8),
                        ),
                      ],)),),


                    Text('Video/Editing Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                      shadows: <Shadow>[

                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 15.0,
                          color: Color.fromRGBO(0, 0, 70, 0.8),
                        ),
                      ],)
                    ),
                  ]
              ))
            ]
        ),),

      Card(
        semanticContainer: true,
        child: Stack(
            children: <Widget>[
              Image.asset('image/David.jpg'),
              Padding(padding: EdgeInsets.only(left:20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom:300),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('David Na', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                            shadows: <Shadow>[

                              Shadow(
                                offset: Offset(0, 0),
                                blurRadius: 15.0,
                                color: Color.fromRGBO(0, 0, 70, 0.8),
                              ),
                            ],)),),


                        Text('Design Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                          shadows: <Shadow>[

                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 15.0,
                              color: Color.fromRGBO(0, 0, 70, 0.8),
                            ),
                          ],)
                        ),
                      ]
                  ))
            ]
        ),),

      Card(
        semanticContainer: true,
        child: Stack(
            children: <Widget>[
              Image.asset('image/Andrew.jpg'),
              Padding(padding: EdgeInsets.only(left:20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom:300),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Andrew Sim', style: TextStyle(fontSize: 30, fontFamily:'MontserratExtraBold', color: Colors.white,
                            shadows: <Shadow>[

                              Shadow(
                                offset: Offset(0, 0),
                                blurRadius: 15.0,
                                color: Color.fromRGBO(0, 0, 70, 0.8),
                              ),
                            ],)),),


                        Text('History Research Leader', style: TextStyle(fontSize: 20, fontFamily:'MontserratExtraBold', color: Colors.white,
                          shadows: <Shadow>[

                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 15.0,
                              color: Color.fromRGBO(0, 0, 70, 0.8),
                            ),
                          ],)
                        ),
                      ]
                  ))
            ]
        ),),
    ]
    ),
    ),



    ])
    ),),


            Scaffold(
              body: SingleChildScrollView(
    child: ConstrainedBox(
    constraints: BoxConstraints(),
    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(left:10, top: 10),
                    child: Text('Contact', style: TextStyle(fontSize: 60, fontFamily: 'MontserratExtraBold')),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text('Contact Us', style: TextStyle(fontSize:25, fontFamily:'MontserratExtraBold' ))
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:20, right: 70, top: 10, bottom: 20),
                    child: Text('If you wish to contact us for any request, suggestion, or other communication, please feel free to contact by any of the following contact information below. We are available 24/7 to reply to your voices!'
                    , style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular')
                  )),
                  Divider(
                    color: Colors.black,
                    thickness: 1
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top:20),
                      child: Text('Get In Touch', style: TextStyle(fontSize: 40, fontFamily: 'MontserratExtraBold'))
                    )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(top:40),
                          child: Icon(
                            Icons.alternate_email,
                            size: 60,
                          )
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(),
                          child: Text('Email', style: TextStyle(fontSize: 30, fontFamily: 'MontserratExtraBold', color: Colors.black))
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(top:10),
                          child: Text('22vzkoreanwar@gmail.com', style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular'))
                      )
                  ),

                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(top:50, left: 150, right: 150),
                          child:  Image.asset('image/youtube_logo.png', ),
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(),
                          child: Text('Youtube', style: TextStyle(fontSize: 30, fontFamily: 'MontserratExtraBold', color: Colors.black))
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(top:10),
                          child: Text('22VZ', style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular'))
                      )
                  ),



                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(top:50, left: 150, right: 150),
                        child:  Image.asset(
                          'image/box.jpg'
                        )
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(),
                          child: Text('Address', style: TextStyle(fontSize: 30, fontFamily: 'MontserratExtraBold', color: Colors.black))
                      )
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.only(right: 60, left:60, top:10),
                          child: Text('603-1701, 158, Seongbok 2-ro, Suji-gu, Yongin-si, Gyeonggi-do, Republic of Korea 16809', style: TextStyle(fontSize: 20, fontFamily: 'MontserratRegular'))
                      )
                  ),

                  Padding(
                    padding: EdgeInsets.only(bottom:60)
                  )

                ]
              )))
            )


          ],
        ),
      ),
    );
  }
}
