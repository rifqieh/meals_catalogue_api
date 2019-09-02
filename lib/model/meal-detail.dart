class MealDetail {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String strCategory;
  final String strArea;
  final String strInstructions;

  MealDetail(
    this.idMeal,
    this.strMeal,
    this.strMealThumb,
    this.strCategory,
    this.strArea,
    this.strInstructions,
  );

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
      json['idMeal'],
      json['strMeal'],
      json['strMealThumb'],
      json['strCategory'],
      json['strArea'],
      json['strInstructions'],
    );
  }
}
