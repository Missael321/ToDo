import 'package:flutter/material.dart';
import 'package:todo/src/pages/TaskForm.dart';
import 'package:todo/src/pages/TaskList.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> tasks = <String>[];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('App ToDo'),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Tareas',
                ),
                Tab(
                  text: 'Agregar Tarea',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: TaskList(),
              ),
              Center(
                child: TaskForm(),
              )
            ],
          ),
        ));
  }
}
