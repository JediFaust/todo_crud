import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'package:todo_crud/model/database.dart'; // CRUD Implementation
import 'package:todo_crud/elements/drawer.dart'; // Drawer
import 'package:todo_crud/elements/appbar.dart';
import 'package:todo_crud/model/todo_item.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MyDrawer(),
      appBar: MyAppBar(scaffoldKey: scaffoldKey),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: Database.readItems(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error initializing database');
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blueAccent,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 5),
                          //height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  snapshot.data!.docs[index].get('is_done') ==
                                          true
                                      ? Colors.greenAccent[100]
                                      : Colors.white),
                          child: ListTile(
                            title: GestureDetector(
                              onDoubleTap: () {
                                TodoItem item = TodoItem(
                                  docId: snapshot.data!.docs[index].id,
                                  content:
                                      snapshot.data!.docs[index].get('content'),
                                  lastUpdated: snapshot.data!.docs[index]
                                      .get('last_updated')
                                      .toDate(),
                                  isDone:
                                      snapshot.data!.docs[index].get('is_done'),
                                );
                                Navigator.pushNamed(context, '/edit',
                                    arguments: item);
                              },
                              child: Text(
                                  "${snapshot.data!.docs[index].get('content')}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            trailing: Text(
                              "${DateFormat.yMMMd().format(snapshot.data!.docs[index].get('last_updated').toDate())}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                            leading: GestureDetector(
                              onTap: () {
                                Database.updateItem(
                                  docId: snapshot.data!.docs[index].id,
                                  content:
                                      snapshot.data!.docs[index].get('content'),
                                  isDone: !snapshot.data!.docs[index]
                                      .get('is_done'),
                                );
                              },
                              child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                      color: snapshot.data!.docs[index]
                                                  .get('is_done') ==
                                              true
                                          ? Colors.greenAccent
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(Icons.done_rounded,
                                      color: Colors.white, size: 22)),
                            ),
                          ),
                        );
                      },
                    );
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
