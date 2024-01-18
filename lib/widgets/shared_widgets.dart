import 'package:flutter/material.dart';
import 'package:path/path.dart';

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

class Dialogs {
  void showAlertDialog(BuildContext ctx, title, content, onYesPressed) {
    showDialog(
        context: ctx,
        builder: (_) => _buildAlertDialog(ctx, title, content, onYesPressed));
  }

  AlertDialog _buildAlertDialog(
      BuildContext ctx, title, String content, onYesPressed) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  onYesPressed();
                },
                child: const Text(
                  'Yes',
                  textAlign: TextAlign.start,
                )),
            const Spacer(),
            ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text(
                  'No',
                  textAlign: TextAlign.end,
                ))
          ],
        ),
      ],
    );
  }

  void showCustomDialog(Widget content, BuildContext ctx) {
    showGeneralDialog(
        context: ctx,
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, anotheranimation) {
          return content;
        });
  }
}
