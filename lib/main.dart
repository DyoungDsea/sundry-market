import 'package:flutter/material.dart'; 
import 'src/constants/app_color.dart';
import 'src/routing/app_router.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hr Live 5.0',
      routerConfig: goRouter,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: orangeColor,
          accentColor: orangeColor,
          backgroundColor: Colors.white,
          cardColor: orangeColor,
        ),
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme:
              IconThemeData(color: Colors.white), // Set the desired color
        ),
      ),
      // home: const GetStarted(),
    );
  }
}


//! Note setting
//change app icon
//change logo
//change color
//change app name
//change image size