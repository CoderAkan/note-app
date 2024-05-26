import "package:flutter/material.dart";
import "package:notes/models/note.dart";
import "package:notes/models/note_database.dart";
import "package:provider/provider.dart";

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // text controller to access what the user typed
  final textController = TextEditingController();

  // on app startup fetch existing notes
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<NoteDatabase>().addNote(textController.text);
              textController.clear();
            },
            child: Text("Create"),
          ),
        ],
      ),
    );
  }

  // read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note
  void editButton(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit the note"),
        content: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: textController.text ?? "Please type something:",
          ),
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              //context
              //    .watch<NoteDatabase>()
              //    .updateNote(id, textController.text ?? "");
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  // delete a note
  void deleteButton(int id) {
    context.watch<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();
    // current notes
    List<Note> notes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          // get individual note
          final note = notes[index];
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // edit button
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => editButton(index),
                ),
                // delete button
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => deleteButton(index),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
