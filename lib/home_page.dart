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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () async {

          Uri url = Uri.parse('http://192.168.3.94/api/v1/stock.php'); 
          http.Response response = await http.get(url, headers: {'user': '1', 'menu': '54', 'module': '16', 'function': 'get_dropdown_fillter_plan',},);
          print(response.body);

        }, child: Text('test', style: TextStyle(fontSize: 50),),),
      ),
    );
  }
}
