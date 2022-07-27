import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

void showToast({
  required String text,
  ToastGravity? gravity,
  Color? backgroundColor,
}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: backgroundColor ?? Colors.blue,
    textColor: Colors.white,
    fontSize: 16,
  );
}
