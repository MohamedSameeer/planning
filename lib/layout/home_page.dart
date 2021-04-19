import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:planning/shared/component/component.dart';
import 'package:planning/shared/cubit/AppCubit.dart';
import 'package:planning/shared/cubit/AppStates.dart';

class HomePage extends StatelessWidget {
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, state) {
            AppCubit cubit = AppCubit.getInstance(context);
            cubit.createDataBase();
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: Text(cubit
                    .screensName[cubit.currentIndex]),
              ),
              body: cubit
                  .screens[cubit.currentIndex],
              floatingActionButton: FloatingActionButton(
                child: cubit.bottomSheetOpened?Icon(Icons.add):Icon(Icons.edit),
                onPressed: () {
                  if(cubit.bottomSheetOpened){
                    if(formKey.currentState.validate()){
                      cubit.insertToDatabase(titleController.text, dateController.text, timeController.text,"New");
                      cubit.changeBottomSheet(false);
                      Navigator.pop(context);
                    }
                  }else {
                    cubit.changeBottomSheet(true);
                    scaffoldKey.currentState.showBottomSheet(
                          (context) =>
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultTextFormField(
                                    controller: titleController,
                                    labelName: "Task Title",
                                    onTap: () {},
                                    validate: (String value){
                                      if(value.isEmpty)
                                        return "Task title must not be empty";
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  defaultTextFormField(
                                    controller: timeController,
                                    labelName: "Task Time",
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {
                                      showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                            timeController.text=value.format(context);
                                      },
                                      );
                                    },
                                    validate:  (String value){
                                      if(value.isEmpty)
                                        return "Task time must not be empty";
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  defaultTextFormField(
                                    controller: dateController,
                                    labelName: "Task Date",
                                    keyboardType: TextInputType.datetime,
                                    onTap: () {
                                      showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2022),
                                      ).then((value) {
                                        dateController.text=DateFormat.yMMMd().format(value);
                                      }

                                      );
                                    },
                                    validate:  (String value){
                                      if(value.isEmpty)
                                        return "Task date must not be empty";
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                    ).closed.then((value) {
                      cubit.changeBottomSheet(false);
                    });
                  }
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  cubit.changeScreen(index);
                },
                currentIndex: cubit.currentIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_outlined),
                    label: "Task",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline),
                    label: "Done",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive),
                    label: "Archive",
                  ),
                ],
              ),
            );
          }),
    );
  }
}
