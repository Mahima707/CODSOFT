import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/done_model/done_model.dart';
import 'package:todo_app/models/boxes.dart';

class DoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: Boxes.getDones().listenable(),
          builder: (context, box, _) {
            final Box<Done> doneBox = Boxes.getDones();
            final List<Done> dones = doneBox.values.toList().cast<Done>();
            return Container(
              child: dones.isEmpty
                  ? Center(
                      child: Text('The list is Empty!'),
                    )
                  : ListView.builder(
                      itemCount: dones.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(dones[index].done),
                      ),
                    ),
            );
          },
        ),
        Positioned(
          right: 15,
          bottom: 10,
          child: OutlinedButton(
            child: Text('Clear list'),
            onPressed: () {
              if (Boxes.getDones().isNotEmpty) {
                Boxes.getDones().clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('List cleared successfully'),
                    duration: Duration(milliseconds: 600),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
