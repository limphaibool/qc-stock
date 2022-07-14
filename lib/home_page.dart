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

  void initState() {}

  String? dateValue;
  String? timeValue;
  String? tableValue;
  bool isChecked = false;
  List checked = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text('Mock UI', style: TextStyle(fontSize: 30))),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      value: dateValue,
                      items: <String>['1', '2', '3', '4']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'วันที่',
                        labelStyle: TextStyle(fontSize: 25),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dateValue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      value: timeValue,
                      items: <String>['13:00', '14:00', '15:00', '16:00']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'เวลาทํางาน',
                        labelStyle: TextStyle(fontSize: 25),
                      ),
                      onChanged: dateValue == null
                          ? null
                          : (String? value) {
                              setState(() {
                                timeValue = value;
                              });
                            },
                      disabledHint: Text(
                        'โปรดเลือกวันที่',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField(
                      value: tableValue,
                      items: <String>[
                        'โต๊ะ 1',
                        'โต๊ะ 2',
                        'โต๊ะ 3',
                        'โต๊ะ 4',
                        'โต๊ะ 5'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'โต๊ะ',
                        labelStyle: TextStyle(fontSize: 25),
                      ),
                      onChanged: timeValue == null
                          ? null
                          : (String? value) {
                              setState(() {
                                tableValue = value;
                              });
                            },
                      disabledHint: Text(
                        'โปรดเลือกเวลาทํางาน',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      child: Text(
                        'ค้นหา',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Table(
                border: TableBorder.all(width: 1, color: Colors.grey),
                children: [
                  TableRow(
                    children: [
                      tableHeader('header'),
                      tableHeader('header'),
                      tableHeader('header'),
                      tableHeader('header'),
                      tableHeader('header'),
                      tableHeader('header'),
                      tableHeader('header'),
                      tableHeader('header'),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableCheckBox(),
                      tableInput(),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                      tableItem('data'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 40),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  primary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: Text(
                  'ยืนยัน',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  print(checked);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tableHeader(String text) {
    return TableCell(
        child: Center(
            child: Padding(
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    )));
  }

  Widget tableInput() {
    return TableCell(
        child: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (value) {},
                ))));
  }

  Widget tableCheckBox() {
    return TableCell(
        child: Center(
            child: Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          if (isChecked) {
            checked.add('1');
          } else {
            checked.remove('1');
          }
        });
      },
    )));
  }

  Widget tableItem(String text) {
    return TableCell(
        child: Center(
            child: Padding(
      padding: EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(fontSize: 12),
      ),
    )));
  }
}
