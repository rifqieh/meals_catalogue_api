class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  Meal(
    this.idMeal,
    this.strMeal,
    this.strMealThumb,
  );

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      json['idMeal'],
      json['strMeal'],
      json['strMealThumb'],
    );
  }
}
