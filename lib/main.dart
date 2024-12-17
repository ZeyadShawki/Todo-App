import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/todo_app/home_layout.dart';
import 'package:flutter_application_1/shared/bloc_observer.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_application_1/shared/network/local/chashed_helper.dart';
import 'package:flutter_application_1/shared/styles/themes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
  var scaffoldKey = GlobalKey<ScaffoldState>();


void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
   
        BlocProvider(
          create: (BuildContext context) => AppCubit()
          
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            darkTheme: lightTheme,
       theme: ThemeData(
   useMaterial3: false,
   primaryColor: Colors.orange,
  primaryColorLight: Colors.orange,

  ),
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}
