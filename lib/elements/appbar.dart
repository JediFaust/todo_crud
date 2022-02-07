import 'package:flutter/material.dart';

import 'package:todo_crud/elements/help.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('My ToDo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      centerTitle: true,
      toolbarHeight: 80,
      elevation: 0,
      backgroundColor: Colors.grey[200],
      leading: GestureDetector(
        onTap: () => scaffoldKey.currentState!.openDrawer(),
        child: const Icon(
          Icons.menu_rounded,
          color: Colors.grey,
          size: 30,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => showHelp(context),
          child: const Icon(
            Icons.help_outline,
            color: Colors.grey,
            size: 30,
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
