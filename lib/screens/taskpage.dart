import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compsci_ia/api/firestoreQuery.dart';
import 'package:compsci_ia/widgets/TodoWidget.dart';
import 'package:compsci_ia/widgets/task.dart';
import 'package:compsci_ia/widgets/todo.dart';
import 'package:flutter/material.dart';
import 'package:compsci_ia/widgets/database_helper.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  TaskPage({@required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbHelper = DatabaseHelper();
  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  String title = "";
  String description = "";
  List<String> todoTask = [];

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisible = false;

  @override
  void initState() {
    if (widget.task != null) {
      _contentVisible = true;
      _taskTitle = widget.task.title;
      _taskId = widget.task.id;
      _taskDescription = widget.task.description;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 24.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            FireStoreQuery().createTodo(
                              description: description,
                              timestamp: Timestamp.now(),
                              title: title,
                              todoItems: todoTask,
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Image(
                              image: AssetImage(
                                  'assets/images/back_arrow_icon.png'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              print("Field Value: $value");

                              //check if the field is not empty
                              if (value != "") {
                                //check if the task is null
                                if (widget.task == null) {
                                  title = value;
                                  // Task _newTask = Task(title: value);
                                  //  _taskId = await _dbHelper.insertTask(_newTask);
                                  setState(() {
                                    _contentVisible = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  // await _dbHelper.updateTaskTitle(
                                  //     _taskId, value);
                                }
                                _descriptionFocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: InputDecoration(
                              hintText: "Enter Task Title",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF211551),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // above is the action bar (it allows the user to name the taskcard)
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextField(
                        focusNode: _descriptionFocus,
                        onSubmitted: (value) {
                          if (value != '') {
                            description = value;
                            // if (_taskId != 0) {
                            //   _dbHelper.updateTaskDescription(_taskId, value);
                            // }
                          }
                          _todoFocus.requestFocus();
                        },
                        controller: TextEditingController()
                          ..text = _taskDescription,
                        decoration: InputDecoration(
                          hintText: "Enter description for the task here",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTodo(_taskId),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (snapshot.data[index].isDone == 0) {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 1);
                                  } else {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 0);
                                  }
                                  setState(() {});
                                },
                                child: TodoWidget(
                                  text: snapshot.data[index].title,
                                  isDone: snapshot.data[index].isDone == 0
                                      ? false
                                      : true,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: _contentVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(
                              right: 12.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: Color(0xFF86829D),
                                  width: 1.5,
                                )),
                          ),
                          Visibility(
                            visible: _contentVisible,
                            child: Expanded(
                              child: TextField(
                                focusNode: _todoFocus,
                                controller: TextEditingController()..text = "",
                                onSubmitted: (value) async {
                                  todoTask.add(value);
                                  if (value != "") {
                                    //check if the task is null
                                    if (_taskId != 0) {
                                      DatabaseHelper _dbHelper =
                                          DatabaseHelper();
                                      Todo _newTodo = Todo(
                                        title: value,
                                        isDone: 0,
                                        taskId: _taskId,
                                      );
                                      await _dbHelper.insertTodo(_newTodo);
                                      setState(() {});
                                      _todoFocus.requestFocus();
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: "Enter todo item",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //above is the code for the description
                ],
              ),
              Visibility(
                visible: _contentVisible,
                child: Positioned(
                  bottom: 24.0,
                  right: 0.0,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image(
                        image: AssetImage(
                          "assets/images/delete_icon.png",
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
