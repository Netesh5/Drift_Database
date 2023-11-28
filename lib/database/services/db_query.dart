import 'package:driftdemo/database/drift_db.dart';

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
}
