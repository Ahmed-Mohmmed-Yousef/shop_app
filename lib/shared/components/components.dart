import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/Products/Products_screen.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';

import 'package:shop_app/shared/styles/themes.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  void Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function() function,
  required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextButton(String title, void Function() onPressed) {
  return TextButton(
    onPressed: onPressed,
    child: Text(title.toUpperCase()),
  );
}

enum ToastStatus {SUCCESS, ERROR, WARNING, INFO}

Color chooseToastColor(ToastStatus status) {
  switch (status) {
    
    case ToastStatus.SUCCESS:
      return Colors.green;
    case ToastStatus.ERROR:
      return Colors.red;
    case ToastStatus.WARNING:
      return Colors.amber;
    case ToastStatus.INFO:
      return Themes.primaryColor;
  }
}

void showToast({
  required String text,
  ToastGravity? gravity,
  ToastStatus? status,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(status ?? ToastStatus.INFO),
    textColor: Colors.white,
    fontSize: 16,
  );
}

class BottomBarItemInfo {
  IconData icon;
  String label;
  BottomBarItemInfo({
    required this.icon,
    required this.label,
  });
}

BottomBarItemInfo getBottomNavBarDate(Widget widget) {
  switch (widget.runtimeType) {
    case CategoriesScreen:
    return BottomBarItemInfo(icon: Icons.apps, label: 'Category');
    case FavoriteScreen:
    return BottomBarItemInfo(icon: Icons.favorite, label: 'Favoriate');
    case ProductsScreen:
    return BottomBarItemInfo(icon: Icons.home, label: 'Home');
    case SearchScreen:
    return BottomBarItemInfo(icon: Icons.search_off_outlined, label: 'Search');
    case SettingsScreen:
    return BottomBarItemInfo(icon: Icons.settings, label: 'Settings');
    default:
    return BottomBarItemInfo(icon: Icons.circle, label: 'Nothing');
  }
}
