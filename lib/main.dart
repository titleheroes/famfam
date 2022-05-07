// ignore_for_file: prefer_const_constructors

import 'package:famfam/Calendar/calendar.dart';
import 'package:famfam/Homepage/history.dart';
import 'package:famfam/circleScreen/createCricle/createciecleScreen.dart';
import 'package:famfam/constants.dart';
import 'package:famfam/register.dart';
import 'package:famfam/screens/components/body.dart';
import 'package:famfam/screens/ticktik_screen.dart';
//import 'package:flutter_famfam/screens/circle_screen.dart';
import 'package:famfam/screens/voterandom_screen.dart';
import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/check-in/Checkin.dart';
import 'package:famfam/loading.dart';
import 'package:famfam/login.dart';
import 'package:famfam/register_info.dart';
import 'package:famfam/welcome.dart';
import 'package:famfam/widgets/circle_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:famfam/services/service_locator.dart';
import 'package:famfam/settingPage/ezmode/ezmode.dart';
import 'package:famfam/settingPage/member/member.dart';
import 'package:famfam/settingPage/profile/Profile.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:famfam/pinpost_screen/pin_screen.dart';
import 'package:famfam/pinpost_screen/reply_pin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Fam app",
      theme: ThemeData(
        scaffoldBackgroundColor: wBackgroundColor,
        primaryColor: kPrimaryColor,
        // textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'members':
            return MaterialPageRoute(builder: (context) => memberPage());
          case 'members_in_circle_Owner':
            return MaterialPageRoute(
                builder: (context) => Profile(
                      profileUser: 0,
                      profileMem: 0,
                      profileOwner: 1,
                    ));
          case 'members_in_circle_Member':
            return MaterialPageRoute(
                builder: (context) => Profile(
                      profileUser: 0,
                      profileMem: 1,
                      profileOwner: 0,
                    ));
          case 'home':
          // default:
          //   return MaterialPageRoute(builder: (context) => Login());
        }
      },
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/welcome': (context) => Welcome(),
        '/register': (context) => Register(),
        '/registerinfo': (context) => Register_Info(),
        '/createcircle': (context) => createCircleScreen(),
        '/login': (context) => Login(),
        '/ticktik': (context) => TickTikScreen(),
        // '/todolist': (context) => TodoBody(),
        '/voterandom': (context) => VoteRandomScreen(),
        '/checkin': (context) => CheckIn(),
        '/pinpost': (context) => PinScreen(),
        '/calendar': (context) => Calendar(),
        '/ciecleLoading': (context) => CircleLoader()
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fam app",
        theme: ThemeData(
          scaffoldBackgroundColor: wBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case 'members':
              return MaterialPageRoute(builder: (context) => memberPage());
            case 'members_in_circle_Owner':
              return MaterialPageRoute(
                  builder: (context) => Profile(
                        profileUser: 0,
                        profileMem: 0,
                        profileOwner: 1,
                      ));
            case 'members_in_circle_Member':
              return MaterialPageRoute(
                  builder: (context) => Profile(
                        profileUser: 0,
                        profileMem: 1,
                        profileOwner: 0,
                      ));
            case 'home':
            // default:
            //   return MaterialPageRoute(builder: (context) => Login());
          }
        },
        // กำหนดให้เริ่มต้นที่หน้า home
        initialRoute: 'home');
  }
}
