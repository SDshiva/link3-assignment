import '../database/database_helper.dart';
import '../models/task_model.dart';

class TaskRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<List<Task>> getTasks() async {
    return await _dbHelper.getTasks();
  }

  Future<void> insertTask(Task task) async {
    await _dbHelper.insertTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _dbHelper.updateTask(task);
  }

  Future<void> deleteTask(int id) async {
    await _dbHelper.deleteTask(id);
  }
}
