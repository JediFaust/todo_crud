import 'package:flutter/material.dart';

final String helpText =
    '* Create Task\n   Press Floating Button with plus icon\n* Edit Task\n   Double Tap on a task\n* Toggle Done|Undone\n   Tap on tasks icon\n* Delete Task\n   Double Tap on a task and Long Press on Delete button';

Future<String?> showHelp(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Help'),
      content: Text(helpText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
