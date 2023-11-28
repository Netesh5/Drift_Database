import 'package:drift/drift.dart';
import 'package:driftdemo/database/drift_db.dart';
import 'package:flutter/foundation.dart';

class EmployeeTableQuery {
  MyDatabase database = MyDatabase();

  //Create
  Future<int> addEmployee(EmployeeCompanion entry) {
    return database.into(database.employee).insert(entry);
  }

// [Adding multiple item using batch]
//   Future<void> insertMultipleEntries() async{
//   await batch((batch) {
//     // functions in a batch don't have to be awaited - just
//     // await the whole batch afterwards.
//     batch.insertAll(employee, [listOfEmployees);
//   });
// }

// Select
  Future<List<EmployeeData>> get fetchEmployeeDetail =>
      database.select(database.employee).get();

// Stream of fetch data whenever new item is added
  Stream<List<EmployeeData>> streamEmployeeDetail(Category c) {
    return (database.select(database.employee)).watch();
  }

  // Selecting with where query

  // Future<List<EmployeeData>> fetchEmployee(String name) {
  //   final employees = (database.select(database.employee))
  //     ..where((tbl) => tbl.name.equals(name))
  //     ..get();

  //    return employees;
  // }

  //Ordering

  //Delete
  void delete(int id) {
    database.delete(database.employee)
      ..where((tbl) => tbl.id.equals(id))
      ..go();
  }
}
