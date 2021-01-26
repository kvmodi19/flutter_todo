import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Todo(),
    );
  }
}

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<String> _todoItems = [];

  // method to add todo
  void _addTodo(String task) {
    if (task.length > 0) {
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _removeItem(index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if (index < _todoItems.length) {
          return _buildTodoItem(_todoItems[index], index);
        }
        return null;
      },
    );
  }

  Widget _buildTodoItem(text, index) {
    return new ListTile(
      title: new Text(text),
      onTap: () => removeTodoPromt(index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Todo App'),
        ),
        body: _todoItems.length != 0
            ? _buildTodoList()
            : Center(
                child: Text(
                  'NO Todo.....',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _pushAddTodoScreen,
          tooltip: 'Add Task',
          child: new Icon(Icons.add),
        ),
      ),
    );
  }

  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: AppBar(
              title: Text('Add Todo'),
            ),
            body: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  autofocus: true,
                  onSubmitted: (val) {
                    _addTodo(val);
                    Navigator.pop(context);
                  },
                  decoration: InputDecoration(
                    hintText: 'add todo',
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void removeTodoPromt(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Mark "${_todoItems[index]}" as done?'),
          actions: [
            new FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('CANCEL'),
            ),
            new FlatButton(
              onPressed: () {
                _removeItem(index);
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            )
          ],
        );
      },
    );
  }
}
