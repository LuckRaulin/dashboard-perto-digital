import 'package:flutter/material.dart';
import 'package:perto_digital_dashboard/constants/colors.dart';
import 'package:perto_digital_dashboard/views/login_view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perto Digital Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        focusColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: ConstantColors.azulCinza),
        ),
      ),
      routes: {
        '/login': (context) => LoginView(),
        '/dashboard': (context) => Material(),
        '/': (context) => Material(),
      },
      initialRoute: '/login',
    );
  }
}
