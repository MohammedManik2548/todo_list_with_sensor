import 'package:flutter/material.dart';

import '../../core/utils/local_storage/database.dart';
import '../../models/todo_model.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> _todoList = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await TodoDatabase.instance.fetchTodos();
    setState(() {
      _todoList = todos;
    });
  }

  Future<void> _addTodo(Todo todo) async {
    await TodoDatabase.instance.insertTodo(todo);
    _loadTodos();
  }

  Future<void> _updateTodo(Todo todo) async {
    await TodoDatabase.instance.updateTodo(todo);
    _loadTodos();
  }

  Future<void> _deleteTodoById(int id) async {
    await TodoDatabase.instance.deleteTodoById(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddTodoDialog();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _todoList.length,
        itemBuilder: (context, index) {
          final todo = _todoList[index];
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.details),
            trailing: Checkbox(
              value: todo.isCompleted,
              onChanged: (bool? value) {
                if (value != null) {
                  setState(() {
                    todo.isCompleted = value;
                    _updateTodo(todo);
                  });
                }
              },
            ),
            onLongPress: () {
              _deleteTodoById(todo.id!);
            },
          );
        },
      ),
    );
  }

  void _showAddTodoDialog() {
    String title = '';
    String details = '';
    String dueDate = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  details = value;
                },
                decoration: InputDecoration(labelText: 'Details'),
              ),
              TextField(
                onChanged: (value) {
                  dueDate = value;
                },
                decoration: InputDecoration(labelText: 'Due Date'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Add'),
              onPressed: () {
                final todo = Todo(
                  title: title,
                  details: details,
                  dueDate: dueDate,
                );
                _addTodo(todo);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
