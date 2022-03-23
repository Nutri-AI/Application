import 'RDI.dart';

NutriStat _$nutriStatFromJson(Map<String, dynamic> json) => NutriStat(
      meal: (json['MEAL'] ?? noMealToday) as List<dynamic>,
      nutrStatus: RDI.fromJson((json['nutr_status'] ??
          noLogToday['nutr_status']) as Map<String, dynamic>),
      rdi: RDI.fromJson(json['RDI'] as Map<String, dynamic>),
      username: json['username'] as String,
    );

Map<String, dynamic> _$nutriStatToJson(NutriStat instance) => <String, dynamic>{
      'MEAL': instance.meal?.toList(),
      'RDI': instance.rdi.toJson(),
      'nutr_status': instance.nutrStatus.toJson(),
      'username': instance.username,
    };

class NutriStat {
  final String username;
  RDI nutrStatus;
  RDI rdi;
  List<dynamic>? meal;

  NutriStat({
    required this.username,
    required this.rdi,
    required this.nutrStatus,
    this.meal,
  });

  factory NutriStat.fromJson(Map<String, dynamic> json) =>
      _$nutriStatFromJson(json);
  Map<String, dynamic> toJson() => _$nutriStatToJson(this);
}

List<String> noMealToday = ['Nan'];

Map<String, dynamic> noLogToday = {
  "nutr_status": {
    "Calories": 0,
    "Carbohydrate": 0,
    "Protein": 0,
    "Fat": 0,
    'Vitamin_B12': 0,
    'Calcium': 0,
    'Iron': 0,
    'Leucine': 0,
    'Histidine': 0,
    'Phenylalanine+Tyrosine': 0,
    'Magnesium': 0,
    'Selenium': 0,
    'Copper': 0,
    'Alpha_Linolenic_Acid': 0,
    'Threonine': 0,
    'Linoleic_Acid': 0,
    'Methionine': 0,
    'Phosphorus': 0,
    'Niacin': 0,
    'Zinc': 0,
    'Sodium': 0,
    'Vitamin_D': 0,
    'Vitamin_C': 0,
    'Lysine': 0,
    'Valine': 0,
    'Vitamin_A': 0,
    'Folic_acid': 0,
    'Dietary_Fiber': 0,
    'Vitamin_E': 0,
    'Vitamin_B6': 0,
    'Potassium': 0,
    'Vitamin_K': 0,
    'Iso_Leucine': 0,
    'Manganese': 0,
  }
};
