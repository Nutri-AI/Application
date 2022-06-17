import 'package:demo/json/RDI.dart';

NutriStat _$nutriStatFromJson(Map<String, dynamic> json) => NutriStat(
      meal: (json['MEAL'] ?? noMealToday) as List<dynamic>,
      nutrStatus: RDI.fromJson((json['nutr_status'] ??
          noLogToday['nutr_status']) as Map<String, dynamic>),
      rdi: RDI.fromJson(json['RDI'] as Map<String, dynamic>),
      username: json['username'] as String,
    );

Map<String, dynamic> _$nutriStatToJson(NutriStat instance) => <String, dynamic>{
      'MEAL': instance.meal.toList(),
      'RDI': instance.rdi.toJson(),
      'nutr_status': instance.nutrStatus.toJson(),
      'username': instance.username,
    };

class NutriStat {
  final String username;
  RDI nutrStatus;
  RDI rdi;
  List<dynamic> meal;

  NutriStat({
    required this.username,
    required this.rdi,
    required this.nutrStatus,
    required this.meal,
  });

  factory NutriStat.fromJson(Map<String, dynamic> json) =>
      _$nutriStatFromJson(json);
  Map<String, dynamic> toJson() => _$nutriStatToJson(this);
}

List<String> noMealToday = ['Nan'];

Map<String, dynamic> noLogToday = {
  "nutr_status": {
    'Calories(kcal)': 0,
    'Carbohydrate(g)': 0,
    'Dietary_fiber(g)': 0,
    'Protein(g)': 0,
    'Fat(g)': 0,
    'Linoleic_acid(g)': 0,
    'Alpha-linolenic_acid(g)': 0,
    'EPA+DHA(mg)': 0,
    'Methionine(g)': 0,
    'Leucine(g)': 0,
    'Isoleucine(g)': 0,
    'Valine(g)': 0,
    'Lysine(g)': 0,
    'Phenylalanine+Tyrosine(g)': 0,
    'Threonine(g)': 0,
    'Tryptophan(g)': 0,
    'Histidine(g)': 0,
    'Vitamin_A(ug)': 0,
    'Vitamin_D(ug)': 0,
    'Vitamin_E(mg)': 0,
    'Vitamin_K(ug)': 0,
    'Vitamin_C(mg)': 0,
    'Vitamin_B1(mg)': 0,
    'Vitamin_B2(mg)': 0,
    'Niacin(mg)': 0,
    'Vitamin_B6(mg)': 0,
    'Folic_acid(ug)': 0,
    'Vitamin_B12(ug)': 0,
    'Pantothenic_acid(mg)': 0,
    'Biotin(ug)': 0,
    'Calcium(mg)': 0,
    'Phosphorus(mg)': 0,
    'Sodium(mg)': 0,
    'Chloride(mg)': 0,
    'Potassium(mg)': 0,
    'Magnesium(mg)': 0,
    'Iron(mg)': 0,
    'Zinc(mg)': 0,
    'Copper(ug)': 0,
    'Manganese(mg)': 0,
    'Iodine(ug)': 0,
    'Selenium(ug)': 0
  }
};
// Map<String, dynamic> noLogToday_2 = {
//   "nutr_status": {
//     "Calories": 0,
//     "Carbohydrate": 0,
//     "Protein": 0,
//     "Fat": 0,
//     'Vitamin_B12': 0,
//     'Calcium': 0,
//     'Iron': 0,
//     'Leucine': 0,
//     'Histidine': 0,
//     'Phenylalanine+Tyrosine': 0,
//     'Magnesium': 0,
//     'Selenium': 0,
//     'Copper': 0,
//     'Alpha_Linolenic_Acid': 0,
//     'Threonine': 0,
//     'Linoleic_Acid': 0,
//     'Methionine': 0,
//     'Phosphorus': 0,
//     'Niacin': 0,
//     'Zinc': 0,
//     'Sodium': 0,
//     'Vitamin_D': 0,
//     'Vitamin_C': 0,
//     'Lysine': 0,
//     'Valine': 0,
//     'Vitamin_A': 0,
//     'Folic_acid': 0,
//     'Dietary_Fiber': 0,
//     'Vitamin_E': 0,
//     'Vitamin_B6': 0,
//     'Potassium': 0,
//     'Vitamin_K': 0,
//     'Iso_Leucine': 0,
//     'Manganese': 0,
//   }
// };
