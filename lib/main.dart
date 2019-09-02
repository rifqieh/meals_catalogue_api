import 'dart:convert';
import 'package:flutter/material.dart';
import 'model/meal.dart';
import 'view/detail.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MealsCataloguePage(),
    );
  }
}

class MealsCataloguePage extends StatefulWidget {
  MealsCataloguePage({Key key}) : super(key: key);
  @override
  _MealsCataloguePageState createState() => _MealsCataloguePageState();
}

class _MealsCataloguePageState extends State<MealsCataloguePage> {
  List<Meal> meals = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    String dataURL = (_selectedIndex == 0)
        ? "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        : "https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood";

    http.Response response = await http.get(dataURL);

    var responseJson = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        meals = (responseJson['meals'] as List)
            .map((p) => Meal.fromJson(p))
            .toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  getBody() {
    if (meals.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return getGridView();
    }
  }

  GridView getGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      padding: EdgeInsets.all(10),
      itemCount: meals.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: GridTile(
            child: Container(
              child: Hero(
                  tag: '${meals[index].idMeal}',
                  child: Image.network('${meals[index].strMealThumb}')),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              title: Text(meals[index].strMeal),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MealDetailPage(
                        title: meals[index].strMeal,
                        index: meals[index].idMeal)));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meals Catalogue'),
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood), title: Text('Dessert')),
          BottomNavigationBarItem(
              icon: Icon(Icons.room_service), title: Text('Seafood')),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
            loadData();
          });
        },
      ),
    );
  }
}
