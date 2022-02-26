import 'package:famfam/Homepage/HomePage.dart';
import 'package:famfam/services/service_locator.dart';
import 'package:famfam/settingPage/ezmode/ezmode.dart';
import 'package:famfam/settingPage/member/member.dart';
import 'package:famfam/settingPage/profile/Profile.dart';
import 'package:famfam/settingPage/settingPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // debugShowCheckedModeBanner: false,
        title: 'Home Page',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
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
            default:
              return MaterialPageRoute(builder: (context) => HomePage());
          }
        },
        // กำหนดให้เริ่มต้นที่หน้า home
        initialRoute: 'home');
  }
}
