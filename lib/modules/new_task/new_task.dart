import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning/shared/component/component.dart';
import 'package:planning/shared/cubit/AppCubit.dart';
import 'package:planning/shared/cubit/AppStates.dart';

class NewTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit=AppCubit.getInstance(context);
    return BlocConsumer<AppCubit,AppStates>(listener: (BuildContext context, state) {  },
      builder: (BuildContext context, state) =>ListView.separated(
          itemBuilder: (context, index)=>ItemList(
              time: cubit.newList[index]["time"],
              title:cubit.newList[index]["title"],
              date: cubit.newList[index]["date"],
              id: cubit.newList[index]["id"],
              context: context,
              onPressedArchive: (){
                cubit.updateInDatabase("Archive", cubit.newList[index]["id"]);

              },
            onPressedDone: (){
              cubit.updateInDatabase("Done", cubit.newList[index]["id"]);
            }

          ),

          separatorBuilder:  (context,index)=>Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
          itemCount:AppCubit.getInstance(context).newList.length
      ),
    );
  }
}
