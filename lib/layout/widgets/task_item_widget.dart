import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.model});

final Map model;

 Widget build(BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
      context.read<AppCubit>().deleteData(id: model['id']);
      },
      child: Padding(

        
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                '${model['time']}',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            IconButton(
                onPressed: () {
                  context.read<AppCubit>()
                      .updateData(status: 'done', id: model['id']);
                },
                icon: Icon(
                  Icons.check_box,
                  color: Color(0xFFF9AD6A),
                )),
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                  context.read<AppCubit>()
                      .updateData(status: 'achieved', id: model['id']);
                },
                icon: Icon(
                  Icons.archive,
                  color: Color(0xFF4397BD),
                )),
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {
                context.read<AppCubit>()
                      .deleteData(id: model['id']);
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                )),
          ],
        ),
      ),
    );

}