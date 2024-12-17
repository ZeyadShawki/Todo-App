import 'package:flutter/material.dart';
import 'package:flutter_application_1/layout/widgets/rounded_text_form_field.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';
import 'package:flutter_application_1/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  //const HomeLayout({Key? key}) : super(key: key);

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => context.read<AppCubit>()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Form(
            key: formKey,
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.orange,
                elevation: 2,
                centerTitle: true,
                title: Text(
                  cubit.titles[cubit.currentIndex],
                ),
              ),
              body: state is! AppGetDatabaseLoadingState
                  ? cubit.screens[cubit.currentIndex]
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.orange,
                child: Icon(
                  cubit.fabIcon,
                ),
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                      );
                      titleController.clear();
                      dateController.clear();
                      timeController.clear();
                    }
                  } else {
                    if (scaffoldKey.currentState == null) {
                      return;
                    }

                    showModalBottomSheet(
                       shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
  ),
                            context: context,
                            builder: (context) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20)),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.all(20),
                                  child: Form(
                                    key: formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RoundedTextFormField(
                                            controller: titleController,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'Title must not be empty';
                                              }
                                              return null;
                                            },
                                            hintText: 'Task Title',
                                            prefixIcon: Icons.title,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          RoundedTextFormField(
                                            inputType: TextInputType.datetime,
                                            controller: timeController,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'Time must not be empty';
                                              }
                                              return null;
                                            },
                                            onTap: () {
                                              showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now())
                                                  .then((value) {
                                                if (value == null) {
                                                  return;
                                                }

                                                timeController.text = value
                                                    .format(context)
                                                    .toString();
                                              });
                                            },
                                            hintText: 'Task Time',
                                            prefixIcon: Icons.timelapse,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          RoundedTextFormField(
                                            onTap: () {
                                              showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.parse(
                                                          '2030-12-05'))
                                                  .then((value) {
                                                if (value == null) {
                                                  return;
                                                }
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value);
                                              });
                                            },
                                            inputType: TextInputType.datetime,
                                            controller: dateController,
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'Date must not be empty';
                                              }
                                              return null;
                                            },
                                            hintText: 'Task Date',
                                            prefixIcon:
                                                Icons.date_range_outlined,
                                          ),
                                          Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (formKey.currentState!
                                                      .validate()) {
                                                    cubit.insertToDatabase(
                                                      title:
                                                          titleController.text,
                                                      time: timeController.text,
                                                      date: dateController.text,
                                                    );
                                                    titleController.clear();
                                                    dateController.clear();
                                                    timeController.clear();

                                                    cubit
                                                        .changeBottomSheetState(
                                                            isShow: true,
                                                            icon: Icons.add);
                                                    cubit
                                                        .changeBottomSheetState(
                                                            isShow: false,
                                                            icon: Icons.edit);
                                                  }
                                                },
                                                child: Center(
                                                  child: Text(
                                                    'Add task',
                                                    style: TextStyle(),
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            elevation: 20)
                        .then((value) {
                      cubit.changeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white.withOpacity(.9),
                elevation: 20,
                unselectedItemColor: Colors.black,
                selectedItemColor: Color(0xFFF9AD6A),
                selectedFontSize: 15,
                unselectedFontSize: 15,
                iconSize: 35,
                selectedLabelStyle: TextStyle(height: 2),
                unselectedLabelStyle: TextStyle(height: 2),
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                  // currentIndex = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_box),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
