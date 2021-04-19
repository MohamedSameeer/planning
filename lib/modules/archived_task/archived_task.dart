import 'package:flutter/material.dart';
import 'package:planning/shared/component/component.dart';
import 'package:planning/shared/cubit/AppCubit.dart';

class ArchivedTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index)=>ItemListWithOutButton(
            time: AppCubit.getInstance(context).archivedList[index]["time"],
            title:AppCubit.getInstance(context).archivedList[index]["title"],
            date: AppCubit.getInstance(context).archivedList[index]["date"],
            id: AppCubit.getInstance(context).archivedList[index]["id"],
          context: context,
        ),
        separatorBuilder:  (context,index)=>Container(
          width: double.infinity,
          height: 1,
          color: Colors.grey[300],
        ),
        itemCount:AppCubit.getInstance(context).archivedList.length
    );
  }
}
