import 'package:drift/drift.dart' as drift;
import 'package:driftdemo/database/drift_db.dart';
import 'package:driftdemo/database/services/db_query.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeTableQuery query = EmployeeTableQuery();
  late TextEditingController nameController;
  late TextEditingController salaryController;

  List<EmployeeData> employeeData = [];

  @override
  void initState() {
    nameController = TextEditingController();
    salaryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "Enter Name "),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: salaryController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: "Enter salary "),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () async {
                    await query
                        .addEmployee(
                      EmployeeCompanion(
                        name: drift.Value(nameController.text),
                        salary: drift.Value(salaryController.text),
                      ),
                    )
                        .then((value) {
                      nameController.clear();
                      salaryController.clear();
                    });
                  },
                  child: const Text(
                    "Add data",
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () async {
                    employeeData = await query.fetchEmployeeDetail;

                    setState(() {});
                  },
                  child: const Text(
                    "Fetch data",
                  ),
                ),
                employeeData.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: employeeData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              employeeData[index].name,
                            ),
                            subtitle: Text(
                              employeeData[index].salary,
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        })
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
