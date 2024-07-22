import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Tile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?) onChanged;
  final Function(BuildContext)? deleteFunction;

  const Tile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(15),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.deepPurple[400],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            children: [
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                checkColor: Colors.deepPurple,
                activeColor: Colors.white,
                side: const BorderSide(color: Colors.white),
              ),
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  decoration: taskCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.white,
                  decorationThickness: 2.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
