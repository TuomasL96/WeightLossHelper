import 'package:flutter/material.dart';

PopupMenuItem buildPopupMenuItem(String title, IconData iconData, onTap) {
  return PopupMenuItem(
    onTap: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          iconData,
          color: Colors.black,
        ),
        Text(title),
      ],
    ),
  );
}
