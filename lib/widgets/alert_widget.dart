import 'package:flutter/material.dart';

showAlertMsg(context, {required String msg, rightbtnTitle = "", callBack}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Text(msg),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.red),
          ),
        ),
        if (rightbtnTitle != "")
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              if (callBack != null) {
                callBack();
              }
            },
            child: Text(
              rightbtnTitle,
              style: TextStyle(color: Colors.grey),
            ),
          ),
      ],
    ),
  );
}
