import 'package:final_project/components/button.dart';
import 'package:final_project/components/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task.dart';
import 'controller/tasks_provider.dart';

class AddTaskScreen extends StatefulWidget {
  Task? task;
  AddTaskScreen({super.key, this.task});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    if (widget.task != null) {
      Provider.of<TasksProvider>(context, listen: false)
          .taskNameController
          .text = widget.task?.name ?? '';
      Provider.of<TasksProvider>(context, listen: false)
          .taskDescriptionController
          .text = widget.task?.description ?? '';
      Provider.of<TasksProvider>(context, listen: false)
          .taskTimeController
          .text = widget.task?.time ?? '';
      Provider.of<TasksProvider>(context, listen: false)
          .taskDateController
          .text = widget.task?.date ?? '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.task != null ? 'Update Task' : 'Add Task',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: provider.form,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SharedTextField(
                    controller: provider.taskNameController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    hint: 'Task Name',
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SharedTextField(
                      controller: provider.taskDescriptionController,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      hint: 'Task Description',
                      maxLines: 5),
                  const SizedBox(
                    height: 20,
                  ),
                  SharedTextField(
                    controller: provider.taskTimeController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    hint: 'Task Time',
                    readOnly: true,
                    onTap: () {
                      showTimePicker(
                              context: context,
                              initialTime: TimeOfDay(
                                  hour: DateTime.now().hour,
                                  minute: DateTime.now().minute))
                          .then((value) {
                        if (value != null) {
                          provider.taskTimeController.text =
                              '${value.hour}:${value.minute > 9 ? value.minute : '0${value.minute}'}';
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SharedTextField(
                    controller: provider.taskDateController,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                    hint: 'Task Date',
                    readOnly: true,
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(DateTime.now().year + 2))
                          .then((value) {
                        if (value != null) {
                          provider.taskDateController.text =
                              value.toString().substring(0, 10);
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SharedButton(
                    title: 'Add',
                    onPressed: () {
                      if (provider.form.currentState!.validate()) {
                        widget.task != null
                            ? provider.updateTask(widget.task!).then((value) {
                                if (value) {
                                  provider.resetForm();
                                  provider.getUserTasks();
                                  Navigator.pop(context);
                                }
                              })
                            : provider.insertTask().then((value) {
                                if (value) {
                                  provider.resetForm();
                                  provider.getUserTasks();
                                  Navigator.pop(context);
                                }
                              });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
