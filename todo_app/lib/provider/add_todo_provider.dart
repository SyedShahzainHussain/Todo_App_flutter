import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodoProvider with ChangeNotifier {
  List<TodoModel> addtodo = [
  TodoModel(id: DateTime.now().toIso8601String(), text: "First Todo", isChecked: false),
  ];

  List<TodoModel> get getTodos => addtodo;
  AddTodoProvider() {
    loadTodo();
  }

  Future<void> loadTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final todosList = prefs.getStringList('todos');
    if (todosList != null) {
      addtodo = todosList.map((data) {
        final todoJson = TodoModel.fromJSON(jsonDecode(data));
        return todoJson;
      }).toList();
      notifyListeners();
    }
  }

  void saveTodo() async {
    final prefs = await SharedPreferences.getInstance();
    final todoList = addtodo.map((todo) => todo.toJson()).toList();
    final jsonList = todoList.map((todo) => jsonEncode(todo)).toList();
    prefs.setStringList("todos", jsonList);
  }

  void addTodo(String text, bool isChecked) {
    addtodo.add(
      TodoModel(
          id: DateTime.now().toIso8601String(),
          text: text,
          isChecked: isChecked),
    );
    saveTodo();
    notifyListeners();
  }

  void deletedTodo(TodoModel todoModel) {
    addtodo.removeWhere((element) => todoModel.id == element.id);
    saveTodo();
    notifyListeners();
  }

  void updateTofo(TodoModel updateTodo) {
    int index = addtodo.indexWhere((element) => updateTodo.id == element.id);
    addtodo[index] = updateTodo;
    saveTodo();
    notifyListeners();
  }
}
