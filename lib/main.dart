import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/src/models/TaskListModel.dart';
import 'package:todo/src/pages/home.dart';
import 'package:todo/src/pages/Login.dart';
import 'package:todo/src/pages/TaskForm.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "/",
        routes: <String, WidgetBuilder>{
          "/": (context) => Login(),
          "/home": (context) => _home(),
          "/editar": (context) => Scaffold(
                appBar: AppBar(title: Text("Editar")),
                body: TaskForm(),
              ),
        });
  }

  Widget _home() {
    return ScopedModel<TaskListModel>(
      model: TaskListModel(),
      child: Home(),
    );
  }
}
