import 'package:flutter/material.dart';
import 'package:todo_crud/elements/help.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text(
              'Jedi Faust',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
            accountEmail: Text(
              'test@mail.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            currentAccountPicture:
                CircleAvatar(backgroundImage: AssetImage('images/avatar.png')),
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/background.png'))),
          ),
          const ListTile(
            title: Text('New features coming soon...'),
            trailing: Icon(Icons.extension),
          ),
          const Divider(),
          ListTile(
            onTap: () => showHelp(context),
            title: const Text('Help'),
            trailing: const Icon(Icons.help_outline_rounded),
          ),
          const SizedBox(height: 400),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: Text('Jedi Production 2022'),
          ),
        ],
      ),
    );
  }
}
