import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/models/TaskListModel.dart';
import 'package:todo/src/models/TaskModel.dart';

class TaskList extends StatelessWidget {
  const TaskList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskList =
        ScopedModel.of<TaskListModel>(context, rebuildOnChange: true).taskList;
    List<Dismissible> taskWidget = taskList.map((TaskModel task) {
      String nivel = task.energia.toString();
      IconData icono;
      if (nivel == 'Energia.baja') {
        icono = Icons.battery_alert;
      }
      if (nivel == 'Energia.media') {
        icono = Icons.battery_full;
      }
      if (nivel == 'Energia.alta') {
        icono = Icons.battery_charging_full;
      }
      return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          child: Icon(Icons.delete),
        ),
        onDismissed: (context) => taskList.remove(task),
        child: ListTile(
          title: Text(task.titulo),
          subtitle: Text(task.fecha.toString()),
          leading: new Icon(icono),
          onLongPress: () {
            Navigator.pushNamed(context, "/editar", arguments: task);
          },
        ),
      );
    }).toList();
    return Container(
      child: ListView(
        children: taskWidget,
      ),
    );
  }
}
