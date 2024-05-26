import "package:flutter/material.dart";
import "package:isar/isar.dart";

// this line is needed to generate the file
// then run: dart run build_runner build
part "note.g.dart";

@Collection()
class Note extends ChangeNotifier {
  Id id = Isar.autoIncrement;
  late String text;
}
