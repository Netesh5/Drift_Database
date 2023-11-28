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
  final EmployeeDao query = EmployeeDao(MyDatabase());
  late TextEditingController nameController;
  late TextEditingController salaryController;
  late TextEditingController specifyEmployeeController;

  List<EmployeeData> employeeData = [];

  List<EmployeeData> searchData = [];

  @override
  void initState() {
    nameController = TextEditingController();
    salaryController = TextEditingController();
    specifyEmployeeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    salaryController.dispose();
    specifyEmployeeController.dispose();
    super.dispose();
  }

  getData() async {
    employeeData = await query.fetchEmployeeDetail;
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
                  height: 20,
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
                  height: 20,
                ),

                // Filter
                TextFormField(
                  controller: specifyEmployeeController,
                  decoration: const InputDecoration(hintText: "Find Employee "),
                ),
                TextButton(
                  onPressed: () async {
                    searchData = await query
                        .selectEmployee(specifyEmployeeController.text);
                    setState(() {});
                  },
                  child: const Text(
                    "Find Employee",
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                searchData.isNotEmpty
                    ? const Text("Item Found")
                    : const Text("Item not found"),
                const SizedBox(
                  height: 50,
                ),
                TextButton(
                  onPressed: () async {
                    await getData();
                    setState(() {});
                  },
                  child: const Text(
                    "Fetch all data",
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
                              onPressed: () async {
                                query.deleteEmployee(employeeData[index].id);
                                await getData();
                                setState(() {});
                              },
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
