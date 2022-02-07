import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_crud/model/todo_item.dart';

import 'package:todo_crud/theme/custom_themes.dart'; //Themes import
import 'package:todo_crud/pages/todo_list.dart'; // ToDo List Page
import 'package:todo_crud/pages/home.dart'; // Home Page
import 'package:todo_crud/pages/add_page.dart';
import 'package:todo_crud/pages/update_page.dart';

void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  initFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple ToDo App',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/todo':
            return MaterialPageRoute(builder: (context) => const TodoList());
            break;
          case '/add':
            return MaterialPageRoute(builder: (context) => const AddPage());
            break;
          case '/edit':
            TodoItem item = settings.arguments as TodoItem;
            return MaterialPageRoute(builder: (context) => UpdatePage(item));
            break;
        }
      },
      home: const HomePage(),
    );
  }
}
