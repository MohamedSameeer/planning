import 'package:flutter/material.dart';
import 'package:planning/shared/cubit/AppCubit.dart';

Widget defaultTextFormField({
  @required TextEditingController controller,
  Function onTap,
  TextInputType keyboardType = TextInputType.text,
  String labelName,
  Function validate,
}) =>
    TextFormField(
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelName,
      ),
      validator: validate,
    );

Widget ItemList({
  @required String time,
  @required String title,
  @required String date,
  @required int id,
  @required BuildContext context,
  Function onPressedArchive,
  Function onPressedDone,
}) =>
    Dismissible(
      key: Key(id.toString()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              radius: 40,
              backgroundColor: Colors.blue[300],
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.archive),
              onPressed: onPressedArchive,
            ),
            IconButton(
              icon: Icon(Icons.check_circle),
              onPressed: onPressedDone,
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.getInstance(context).deleteFromDatabase(id);
      },
    );

Widget ItemListWithOutButton({
  @required String time,
  @required String title,
  @required String date,
  @required int id,
  @required BuildContext context,
}) =>
    Dismissible(
      key: Key(id.toString()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              radius: 40,
              backgroundColor: Colors.blue[300],
            ),
            SizedBox(
              width: 16.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[300],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.getInstance(context).deleteFromDatabase(id);
      },
    );

