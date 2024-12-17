import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/widgets/task_list_widget.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedTasks extends StatelessWidget {
  //const NewTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).archivedTasks;
        return TaskListWidget(tasks:
            tasks,
        );
      },
    );
  }
}
