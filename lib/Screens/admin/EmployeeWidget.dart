import 'package:flutter/material.dart';
import 'package:railway_alert/models/emp_resp_model.dart';

class EmployeeWidget extends StatefulWidget {
  EmployeeWidget({Key? key, this.empData}) : super(key: key);
  List<EmpData>? empData;

  @override
  State<EmployeeWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<EmployeeWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.empData?.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: const Icon(Icons.list),
              title: Text(
                widget.empData![index].name!,
                style: const TextStyle(color: Colors.green, fontSize: 15),
              ),
              trailing: Text("List item $index"));
        });
  }
}
