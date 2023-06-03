import 'package:flutter/material.dart';

class DialogUtils {
  static void showProgressDialog(BuildContext context, String message,
      {bool isDismissible = true}) {
    showDialog(
      context: context,
      builder: (buildContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          )),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 20,
              ),
              Text(message),
            ],
          ),
        );
      },
      barrierDismissible: false,
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showMessage(BuildContext context, String message,
      {String? posActionText,
      VoidCallback? posAction,
      String? negActionText,
      VoidCallback? negAction,
      bool isDismissible = true}) {
    List<Widget> actions = [];
    if (posActionText != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (posAction != null) {
            posAction();
          }
        },
        child: Text(posActionText,
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: Theme.of(context).primaryColor,
                )),
      ));
    }
    if (negActionText != null) {
      actions.add(TextButton(
        onPressed: () {
          Navigator.pop(context);
          if (negAction != null) {
            negAction();
          }
        },
        child: Text(
          negActionText,
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).primaryColor,
              ),
        ),
      ));
    }
    showDialog(
      context: context,
      builder: (buildContext) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            )),
            content: Text(
              message,
              style: Theme.of(context).textTheme.headline6,
            ),
            actions: actions,
          ),
        );
      },
      barrierDismissible: isDismissible,
    );
  }
}
