import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AppManual extends StatelessWidget {
  const AppManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = 'https://www.youtube.com/watch?v=8hbzk9cW6Qk&ab_channel=22VZ';
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: "${YoutubePlayer.convertUrlToId(url)}",
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    return ScreenUtilInit(
        designSize: Size(390, 763),

    builder: () => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('App Manual', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),


            Padding(child: Text('Home', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),),
              padding: EdgeInsets.only(left: 20.sp, top: 20.sp, bottom: 20.sp)
            ),
            Image.asset('image/homeManual.png'),
            Padding(child: Text('Menu', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),),
                padding: EdgeInsets.only(left: 20.sp,bottom: 20.sp, top: 40.sp)
            ),
            Image.asset('image/Drawer Menu.png'),
            Padding(child: Text('General Forum', style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),),
                padding: EdgeInsets.only(left: 20.sp, bottom: 20.sp, top: 40.sp)
            ),
            Image.asset('image/General Forum.png'),
            Padding(child: Text('Posting Page', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                padding: EdgeInsets.only(left: 20.sp, bottom: 20.sp, top: 40.sp)
            ),
            Image.asset('image/Forum-Posting Page.png'),
            Padding(child: Text('Korea-Today Page', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                padding: EdgeInsets.only(left: 20.sp, bottom: 20.sp, top: 40.sp)
            ),
            Image.asset('image/Korea Today.png')

          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        )
      )
    ));
  }
}
