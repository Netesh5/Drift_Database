import 'package:drift/drift.dart';
import 'package:driftdemo/database/drift_db.dart';
part 'db_query.g.dart';

@DriftAccessor(tables: [Employee])
class EmployeeDao extends DatabaseAccessor<MyDatabase> with _$EmployeeDaoMixin {
  EmployeeDao(super.database);

  //Create
  Future<int> addEmployee(EmployeeCompanion entry) {
    return into(employee).insert(entry);
  }

// // [Adding multiple item using batch]
// //   Future<void> insertMultipleEntries() async{
// //   await batch((batch) {
// //     // functions in a batch don't have to be awaited - just
// //     // await the whole batch afterwards.
// //     batch.insertAll(employee, [listOfEmployees);
// //   });
// // }

// Select
  Future<List<EmployeeData>> get fetchEmployeeDetail => select(employee).get();

// Stream of fetch data whenever new item is added
  Stream<List<EmployeeData>> streamEmployeeDetail() {
    return (select(employee)).watch();
  }

//   //Selecting with where query

  Future<List<EmployeeData>> selectEmployee(String name) {
    final employees = select(employee)..where((tbl) => tbl.name.equals(name));

    return employees.get();
  }

  //Delete

  deleteEmployee(int id) {
    delete(employee)
      ..where((tbl) => tbl.id.equals(id))
      ..go();
  }

  //Update

  updateEmployee(EmployeeCompanion entry) {
    return update(employee).replace(entry);
  }
}
