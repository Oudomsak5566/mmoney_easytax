import 'package:easytax/pages/HomePage.dart';
import 'package:easytax/pages/LoginPage.dart';
import 'package:easytax/pages/MarkLocationFormPage.dart';
import 'package:easytax/provider/LocationProvider.dart';
import 'package:easytax/provider/MainProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        // 
        ChangeNotifierProvider<LocationProvider>(
            create: (_) => LocationProvider()),
        ChangeNotifierProvider<MainProvider>(
            create: (_) => MainProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/home": (context) => HomPage(),
        "/marker": (context) => MarkLocationFormPage()
      },
    );
  }
}
// AIzaSyBlbMg6rxRm0cUzmGZNxpVd6QhrPdOKH7M