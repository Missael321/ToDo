import 'package:scoped_model/scoped_model.dart';
import 'package:todo/src/models/TaskModel.dart';

class TaskListModel extends Model {
  List<TaskModel> _taskList = List<TaskModel>();

  List<TaskModel> get taskList => _taskList;

  void add(TaskModel task) {
    _taskList.add(task);
    notifyListeners();
  }

  void edit(TaskModel task) {
    _taskList.remove(task);
    _taskList.add(task);
    notifyListeners();
  }
}
