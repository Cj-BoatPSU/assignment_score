import 'package:assigement_1/config/routes.dart';
import 'package:assigement_1/presentation/home_page.dart';
import 'package:assigement_1/presentation/compare_page.dart';
import 'package:assigement_1/presentation/addlistperson.dart';
import 'package:assigement_1/presentation/edit_page.dart';
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
      initialRoute: '/',
       routes: {
         '/': (context) => HomePageScreen(),
       },
      onGenerateRoute: _registerRWP,
    );
  }

  Route _registerRWP(RouteSettings settings){
    if(settings.name == AppRoutes.compare){
      return MaterialPageRoute(builder: (context){
        ComparePageParameter param = settings.arguments;
        return ComparePageScreen(param.personslist, param.thisperson, param.nextperson,);
      });
    }
    else if(settings.name == AppRoutes.addperson){
      return MaterialPageRoute(builder: (context){
        AddPersonPageParameter param = settings.arguments;
        return AddPersonPageScreen(param.personslength);
      });
    }
     else if(settings.name == AppRoutes.editperson){
      return MaterialPageRoute(builder: (context){
        EditPageParameter param = settings.arguments;
        return EditPageScreen(param.thisperson);
      });
    }
  }
}