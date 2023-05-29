import 'package:final_project/pages/tasks/add_task.dart';
import 'package:final_project/pages/tasks/controller/tasks_provider.dart';
import 'package:final_project/pages/tasks/task_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/task.dart';

class TaskChooise extends StatelessWidget {
  Task task;
  TaskChooise({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 10,
          right: 10,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 40,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TasksDetails(
                              task: task,
                            )),
                  );
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.view_kanban_outlined,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Show',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTaskScreen(
                            task: task,
                          )),
                );
              },
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Edit',
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                provider.deleteTask(task.id ?? 0).then((value) {
                  if (value) {
                    provider.taskFilter = -1;
                    provider.getUserTasks();
                    Navigator.pop(context);
                  }
                });
              },
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Delete',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: Colors.red,
                          ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    });
  }
}
