import 'package:flutter/material.dart';

import 'package:todo_crud/elements/appbar.dart';
import 'package:todo_crud/elements/drawer.dart';
import 'package:todo_crud/model/database.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  labelText: 'Enter a new task',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: _taskSubmit,
                  child: const Text('Add Task',
                      style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _taskSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Database.addItem(content: _contentController.text);

      print(_contentController.text);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, '/todo', ModalRoute.withName('/'));
    } else {
      print('Form is not valid');
    }
  }

  String? _contentValidator(String? value) {
    if (value!.isEmpty) {
      return 'Task cannot be empty';
    } else {
      return null;
    }
  }
}
