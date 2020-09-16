import 'package:assigement_1/config/routes.dart';
import 'package:assigement_1/presentation/home_page.dart';
import 'package:assigement_1/presentation/add_page.dart';
import 'package:assigement_1/presentation/show_page.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigator',
      //home: HomeScreen(), is optional
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        //AppRoutes.show: (context) => ShowPageScreen(),
        AppRoutes.add: (context) => AddScreen(),
      },
      onGenerateRoute: _registerRWP,
    );
  }

  Route _registerRWP(RouteSettings settings){
    if(settings.name == AppRoutes.show){
      return MaterialPageRoute(builder: (context){
        ShowPageParameter param = settings.arguments;
        return ShowPageScreen(title: param.title, score: param.score);
      });
    }
  }
}