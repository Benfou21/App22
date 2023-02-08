import 'package:flutter/material.dart';
import 'homePage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'list_page.dart';
import 'login_screen.dart';
import 'Welcome_screen.dart';
import 'registration_screen.dart';
import 'Navpage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/nav': ((context) => NavPage()),
          '/welcome_screen': (context) => const Welcome_screen(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegistrationScreen(),
          '/home_page': (context) => HomePage(),
          '/list_page': (context) => const List_page(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                return NavPage();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            // means connection to future hasnt been made yet
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Welcome_screen();
          },
        ),
      ),
    );
  }
}
