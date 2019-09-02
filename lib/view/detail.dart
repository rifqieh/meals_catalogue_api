import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:daftarmakanan/model/meal-detail.dart';

class MealDetailPage extends StatefulWidget {
  final String title;
  final String index;
  MealDetailPage({Key key, this.title, this.index}) : super(key: key);
  @override
  _MealDetailPageState createState() => _MealDetailPageState();
}

class _MealDetailPageState extends State<MealDetailPage> {
  List<MealDetail> detail = [];

  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    String dataURL =
        "https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.index}";

    http.Response response = await http.get(dataURL);

    var responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        detail = (responseJson['meals'] as List)
            .map((p) => MealDetail.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  getBody() {
    if (detail.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return ListView(
      children: <Widget>[
        Hero(
          tag: '${widget.index}',
          child: Image.network('${detail[0].strMealThumb}'),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              '${detail[0].strMeal}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text('Category: ${detail[0].strCategory}')),
        Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text('Area: ${detail[0].strArea}')),
        Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
            child: Text('Instruction: \n${detail[0].strInstructions}')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: getBody(),
    );
  }
}
