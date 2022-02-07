import 'dart:io';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 150, horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 64,
              width: 64,
              child:
                  const Icon(Icons.done_rounded, color: Colors.white, size: 48),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Container(
              height: 140,
              width: 320,
              //margin: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text('Welcome to', style: TextStyle(fontSize: 24)),
                  Text('My ToDo',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                      'My ToDo helps you to organize your daily tasks and stay productive all day long!',
                      style: TextStyle(fontSize: 18),
                      maxLines: 2),
                ],
              ),
            ),
            const SizedBox(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/todo');
                      },
                      child: const Text('Try Now!')),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: const Text('No thanks')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
