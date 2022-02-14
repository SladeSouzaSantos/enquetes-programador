import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final primaryColor = Color.fromRGBO(51, 153, 255, 1);
    final primaryColorDark = Color.fromRGBO(51, 102, 153, 1);
    final primaryColorLight = Color.fromRGBO(138, 198, 209, 1);

    return MaterialApp(
      title: "4Dev",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        accentColor: primaryColor,
        backgroundColor: Colors.white,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColorDark
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColorLight
            )
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: primaryColor
              )
          ),
          alignLabelWithHint: true
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColor,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)
        ),
      ),
      home: LoginPage(),
    );
  }
}
