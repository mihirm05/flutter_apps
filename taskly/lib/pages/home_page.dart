import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  HomePage();
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

// this is a private and class is not going to be accessible outside this file
class _HomePageState extends State<HomePage> {
  late double _deviceHeight, _deviceWidth;

  String? _newTaskContent;
  Box? _box;

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text("Taskly!",
            style: TextStyle(
              fontSize: 25,
            )),
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksView() {
    return FutureBuilder(
      /* future: Future.delayed(
        const Duration(
          seconds: 2),), */ // this shows the circular progress bar for 2 seconds and then loads the _taskslist()
      future: Hive.openBox(
          'tasks'), // openBox(): opens (initializes) a container in which we can put our data
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box = _snapshot.data; //_data holds the return value of the future
          return _tasksList();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _tasksList() {
    List tasks = _box!.values.toList();
    /*Task _newTask = Task(
      content: "Throw Trash", 
      timestamp: DateTime.now(), 
      done: false);
      _box?.add(_newTask.toMap());*/
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext _context, int _index) {
        var task = Task.fromMap(tasks[_index]);
        return ListTile(
          title: Text(task.content,
              style: TextStyle(
                decoration: task.done ? TextDecoration.lineThrough : null,
              )),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
              task.done
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_outlined,
              color: Colors.red),
          onTap: () {
              task.done = !task.done;
              _box!.putAt(_index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _box!.deleteAt(_index);
            setState(() {     });
          } ,
        );
      },
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
        context: context,
        // builder responsible for rendering how the alert should look like
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text("Add New Task!"),
            content: TextField(
              onSubmitted: (_value) {
                if (_newTaskContent != null) {
                  var _task = Task(
                      content: _newTaskContent!,
                      timestamp: DateTime.now(),
                      done: false);
                  _box!.add(_task.toMap());
                  setState(() {
                    _newTaskContent = null;
                    Navigator.pop(context);
                  });
                }
              },
              onChanged: (_value) {
                setState(() {
                  _newTaskContent = _value;
                });
              },
            ),
          );
        });
  }
}
