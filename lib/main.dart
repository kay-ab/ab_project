// import 'package:firebase_core/firebase_core.dart';
// import 'dart:js';

// import 'dart:js';

import 'package:ab_project/auth/login_status.dart';
import 'package:ab_project/auth/store.dart';
import 'package:ab_project/ui/home.dart';
import 'package:ab_project/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LoginStatus()),
      ChangeNotifierProvider(create: (context)=> Store()),
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AB News',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'AB News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    bool status = Provider.of<LoginStatus>(context).status;
    return Scaffold(
      body: (status) ? 
      home() : LoginScreen()
    );
  }
}
