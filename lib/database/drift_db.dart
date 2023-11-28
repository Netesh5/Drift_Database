import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'drift_db.g.dart';

@DriftDatabase(tables: [Employee], daos: [])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnectivity());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnectivity() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}

class Employee extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get salary => text()();
}
