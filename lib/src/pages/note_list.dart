import 'package:flutter/material.dart';
import 'package:restapiiii/src/models/note_for_listing.dart';
import 'package:restapiiii/src/pages/node_modify.dart';
import 'package:restapiiii/src/pages/note_delete.dart';

class NoteList extends StatelessWidget {
  final notes = [
    NoteForListing(
        noteID: "1",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 1"),
    NoteForListing(
        noteID: "2",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 2"),
    NoteForListing(
        noteID: "3",
        createDateTime: DateTime.now(),
        lastEditDateTime: DateTime.now(),
        noteTitle: "Note 3")
  ];

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of notes'),
      ),
      body: ListView.separated(
        itemBuilder: (_, index) => Dismissible(
          key: ValueKey(
            notes[index].noteID,
          ),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction) {},
          confirmDismiss: (direction) async {
            final result = await showDialog(
              context: context,
              builder: (_) {
                return NoteDelete();
              },
            );
            print(result);
            return result;
          },
          background: Container(
            color: Colors.red,
            padding: EdgeInsets.only(
              left: 16.0,
            ),
            child: Align(
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          child: ListTile(
            title: Text(
              notes[index].noteTitle,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            subtitle: Text(
                'Last edited on ${formatDateTime(notes[index].lastEditDateTime)}'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => NoteModify(
                    noteID: notes[index].noteID,
                  ),
                ),
              );
            },
          ),
        ),
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: Colors.green,
        ),
        itemCount: notes.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => NoteModify(),
            ),
          );
        },
      ),
    );
  }
}
