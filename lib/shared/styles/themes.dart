import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Themes {
  static MaterialColor primaryColor = Colors.blue;
  static ThemeData lightTheme = ThemeData(
              secondaryHeaderColor: Colors.grey,
              primarySwatch: primaryColor,
              // floatingActionButtonTheme: const FloatingActionButtonThemeData(
              //   backgroundColor: Colors.deepOrange,
              //   elevation: 0.0,
              // ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.deepOrange),
                actionsIconTheme: IconThemeData(
                  color: Colors.black87,
                  opacity: 0.5,
                  // size: 30,
                ),
                centerTitle: false,
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              fontFamily: 'Jannah',
            );

  static ThemeData darkTheme = ThemeData(
              secondaryHeaderColor: Colors.grey,
              primarySwatch: primaryColor,
              // floatingActionButtonTheme: const FloatingActionButtonThemeData(
              //   backgroundColor: Colors.deepOrange,
              //   elevation: 0.0,
              // ),
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(color: Colors.deepOrange),
                actionsIconTheme: const IconThemeData(
                  color: Colors.white,
                  opacity: 0.8,
                  // size: 30,
                ),
                centerTitle: false,
                backgroundColor: HexColor('333739'),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: HexColor('333739'),
              ),
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              fontFamily: 'Jannah',
            );

}