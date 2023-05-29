import 'package:final_project/models/task.dart';
import 'package:final_project/components/button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/tasks_provider.dart';

class TasksDetails extends StatelessWidget {
  Task task;
  TasksDetails({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksProvider>(builder: (context, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            '${task.name} Details'
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.name ?? '',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.date_range,
                          color: Colors.blue[200],
                          size: 18,
                        ),
                        Text(
                          task.time ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: Colors.blue[200],
                          size: 18,
                        ),
                        Text(
                          task.date ?? '',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Text(
                  task.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              if (task.stauts == 0)
                SharedButton(
                  onPressed: () {
                    provider.doneTask(task).then((value) {
                      provider.taskFilter = -1;
                      provider.getUserTasks();
                      Navigator.pop(context);
                    });
                  },
                  title: 'Done',
                  color: Colors.green,
                ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
    });
  }
}
