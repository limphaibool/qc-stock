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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('stock app', style: TextStyle(fontSize: 30))),
      body: Container(
        child: Column(
          children: [
            DropdownButton<String>(
                value: dropDownValue,
                items: planScheduleList.map(
                  (e) {
                    return DropdownMenuItem(
                        value: PlanSchedule.fromJson(e as Map<String, dynamic>).id, child: Text(PlanSchedule.fromJson(e as Map<String, dynamic>).value ?? ''));
                  },
                ).toList(),
                onChanged: (String? value) {
                  setState(() {

                    dropDownValue = value;
                  });
                }),
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
            TextButton(
                onPressed: () {
                  print(dropDownValue);
                },
                child: Text('test'))
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
