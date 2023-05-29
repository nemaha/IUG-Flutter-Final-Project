import 'package:final_project/components/button.dart';
import 'package:final_project/pages/tasks/controller/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksFilter extends StatelessWidget {
  TasksFilter({super.key});

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        provider.addFilter(-1);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'CLEAR',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Colors.blue,
                            ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Radio(
                    groupValue: provider.taskFilter,
                    value: 1,
                    onChanged: (value) {
                      provider.addFilter(1);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Done',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  Radio(
                    groupValue: provider.taskFilter,
                    value: 0,
                    onChanged: (value) {
                      provider.addFilter(0);
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Pending',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(),
                  )
                ],
              ),
            ),
            // const SizedBox(
            //   height: 15,
            // ),
            // SharedButton(
            //     onPressed: () {
            //       provider.getUserTasks();
            //       Navigator.pop(context);
            //     },
            //     title: 'Search'),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      );
    });
  }
}
