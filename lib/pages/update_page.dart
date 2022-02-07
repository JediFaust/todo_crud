import 'package:flutter/material.dart';

import 'package:todo_crud/elements/appbar.dart';
import 'package:todo_crud/elements/drawer.dart';
import 'package:todo_crud/model/database.dart';
import 'package:todo_crud/model/todo_item.dart';

class UpdatePage extends StatefulWidget {
  late final TodoItem item;

  UpdatePage(this.item);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _contentController.text = widget.item.content ??= 'Empty task';
    super.initState();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MyDrawer(),
      appBar: MyAppBar(scaffoldKey: scaffoldKey),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _contentController,
                validator: _contentValidator,
                autofocus: true,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text('Enter new text'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        _showSnackBar(context);
                      },
                      onLongPress: () {
                        Database.deleteItem(docId: widget.item.docId ??= '');
                        Navigator.pop(context);
                      },
                      child: const Text('Delete Task',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      )),
                  ElevatedButton(
                      onPressed: _taskSubmit,
                      child: const Text('Edit Task',
                          style: TextStyle(color: Colors.white)),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.amber),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Submitting function
  void _taskSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Database.updateItem(
          docId: widget.item.docId,
          content: _contentController.text,
          isDone: widget.item.isDone);

      print(_contentController.text);
      Navigator.pushNamedAndRemoveUntil(
          context, '/todo', ModalRoute.withName('/'));
    } else {
      print('Form is not valid');
    }
  }

  // Validators Part
  String? _contentValidator(String? value) {
    if (value!.isEmpty) {
      return 'Task cannot be empty';
    } else {
      return null;
    }
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 3),
      content: Text('Long press on Delete Button again to delete task'),
      //action: SnackBarAction(label: 'undo', onPressed: () {}),
    ));
  }
}
