import 'dart:async';
import 'package:blockemployee/employee.dart';

class EmployeeBlock {
  // Sink to add in pipe
  // Stream to get data from pipe
  // By Pipe I mean dataflow or stream

  List<Employee> _employeeList = [
    Employee(1, "Akshay Bengani", 80000.0),
    Employee(2, "Shivank Gautam", 40000.0),
    Employee(3, "Aastha Jain", 30000.0),
    Employee(4, "Prashant Pandey", 20000.0),
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // Getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;
  StreamSink<Employee> get employeesalaryincrement =>
      _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeesalarydecrement =>
      _employeeSalaryDecrementStreamController.sink;

  EmployeeBlock() {
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
