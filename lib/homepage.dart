import 'package:flutter/material.dart';
import 'package:blockemployee/employee.dart';
import 'package:blockemployee/employeeBlock.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final EmployeeBlock _employeeBlock = EmployeeBlock();

  @override
  void dispose() {
    _employeeBlock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee App"),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBlock.employeeListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            if (snapshot.hasError) return Text("Error ");
            if (snapshot.connectionState == ConnectionState.waiting)
              return Text("Loading Data...");
            if (snapshot.connectionState == ConnectionState.active)
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5.00,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "${snapshot.data[index].id}.",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${snapshot.data[index].name}",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "₹ ${snapshot.data[index].salary}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_up, color: Colors.green),
                            onPressed: () {
                              _employeeBlock.employeesalaryincrement
                                  .add(snapshot.data[index]);
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(Icons.thumb_down, color: Colors.red),
                            onPressed: () {
                              _employeeBlock.employeesalarydecrement
                                  .add(snapshot.data[index]);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
          },
        ),
      ),
    );
  }
}
