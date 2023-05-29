import 'dart:developer';
import 'package:final_project/pages/tasks/widgets/task_chooise_dialog.dart';
import 'package:final_project/pages/tasks/widgets/task_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_task.dart';
import 'controller/tasks_provider.dart';

class AllTaskScreen extends StatefulWidget {
  int userId;
  AllTaskScreen({super.key, required this.userId});

  @override
  State<AllTaskScreen> createState() => _AllTaskScreenState();
}

class _AllTaskScreenState extends State<AllTaskScreen> {
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<TasksProvider>(context).user == null)
      Provider.of<TasksProvider>(context).getUser(widget.userId);
    // else  
    //   Provider.of<TasksProvider>(context).getUserTasks();  
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'My Task',
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: false,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  builder: (context) {
                    return TasksFilter();
                  },
                );
              },
              icon: Icon(Icons.filter_list_rounded))
        ],
      ),
      body: Consumer<TasksProvider>(builder: (context, provider, child) {
          return ListView.builder(
            padding: EdgeInsets.only(
              top: 25,
              bottom: 80,
            ),
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (provider.tasks[index].stauts == 1)
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          if (provider.tasks[index].stauts == 1)
                            const SizedBox(
                              width: 5,
                            ),
                          Expanded(
                            child: Text(
                              provider.tasks[index].name??'',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: false,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15),
                                    ),
                                  ),
                                  builder: (context) {
                                    return TaskChooise(
                                      task: provider.tasks[index],
                                    );
                                  },
                                );
                              },
                              child:  Icon(Icons.more_vert))
                        ],
                      ),
                       SizedBox(
                        height: 15,
                      ),
                      Text(
                        provider.tasks[index].description??'',
                        style: Theme.of(context).textTheme.bodyMedium,
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
                                  provider.tasks[index].time??'',
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
                                  provider.tasks[index].date??'',
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddTaskScreen()));
        },
      ),
    );
  }
}
