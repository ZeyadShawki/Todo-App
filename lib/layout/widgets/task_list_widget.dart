import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/widgets/task_item_widget.dart';
import 'package:flutter_application_1/shared/components/components.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key, required this.tasks});
final List<Map> tasks;
  @override
  Widget build(BuildContext context) =>
     tasks.length > 0?
         ListView.separated(
            itemBuilder: (context, index) =>
                TaskItem(model: tasks[index], ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: tasks.length)
   :
         Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                  color: Colors.orange,
                size: 90,
              ),
              Text(
                'No Tasks yet, please add some tasks.....',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ],
          ),
        );
      
  
}