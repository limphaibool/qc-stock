import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List planScheduleList = [];

  void initState() {
    callAPI();
  }

  void callAPI() async {
    Uri url = Uri.parse('http://192.168.3.94/api/v1/stock.php');
    http.Response response = await http.get(
      url,
      headers: {
        'user': '1',
        'menu': '54',
        'module': '16',
        'function': 'get_dropdown_fillter_plan',
      },
    );
    var res = jsonDecode(response.body);
    print(res);
    setState(() {
      planScheduleList = res[0]['plan_schedule_type_id'];
    });
  }

  void mapObject() {
    print(planScheduleList);
    PlanSchedule plan1 = PlanSchedule.fromJson(planScheduleList[0]);
    print(plan1.id);
    print(plan1.value);
  }

  @override
  String? dropDownValue = '1';
  String? dropdownValue1 = 'Select value 1';
  String? dropdownValue2 = 'A';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('stock app', style: TextStyle(fontSize: 30))),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            DropdownButton<String>(
              value: dropdownValue1,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue1 = newValue!;
                });
              },
              items: <String>['Select value 1', 'One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            dropdownValue1 != 'Select value 1'
                ? DropdownButton<String>(
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items: <String>['Select value 2', 'A', 'B', 'C', 'D']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                : Container(),
            Row(
              children: [
                Text('Plan schedule'),
                SizedBox(width: 20),
                DropdownButton<String>(
                    hint: Text(
                      'plan schedule',
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: dropDownValue,
                    items: planScheduleList.map(
                      (e) {
                        return DropdownMenuItem(
                            value:
                                PlanSchedule.fromJson(e as Map<String, dynamic>)
                                    .id,
                            child: Text(
                                PlanSchedule.fromJson(e as Map<String, dynamic>)
                                        .value ??
                                    ''));
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        dropDownValue = value;
                      });
                    }),
              ],
            ),
            // DropdownButton(value: dropDownValue, items: planScheduleList.map<DropdownMenuItem>((String value) {
            //   return DropdownMenuItem<String>(
            //     value: value,
            //     child: Text('test'),
            //   );
            // }).toList(), onChanged: (String? value) {
            //   setState(() {
            //     dropDownValue = value;
            //   });
            // },),
            dropdownValue1 == 'Select value 1'
                ? TextButton(
                    onPressed: () {},
                    child: Text('test'),
                  )
                : Container(),
            Table(
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Text('test table'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlanSchedule {
  String? id;
  String? value;

  PlanSchedule({this.id, this.value});

  factory PlanSchedule.fromJson(Map<String, dynamic> json) {
    return PlanSchedule(
      id: json['id'],
      value: json['value1'],
    );
  }
}
