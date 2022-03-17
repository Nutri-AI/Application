/////////////// RDI INFO JSON //////////////////

RDI _$RDIFromJson(Map<String, dynamic> json) => RDI(
      Vitamin_B12: json['Vitamin_B12'] as dynamic,
      Calcium: json['Calcium'] as dynamic,
      Iron: json['Iron'] as dynamic,
      Leucine: json['Leucine'] as dynamic,
      Histidine: json['Histidine'] as dynamic,
      Phenylalanine_Tyrosine: json['Phenylalanine+Tyrosine'] as dynamic,
      Carbohydrate: json['Carbohydrate'] as dynamic,
      Magnesium: json['Magnesium'] as dynamic,
      Selenium: json['Selenium'] as dynamic,
      Copper: json['Copper'] as dynamic,
      Alpha_Linolenic_Acid: json['Alpha_Linolenic_Acid'] as dynamic,
      Threonine: json['Threonine'] as dynamic,
      Linoleic_Acid: json['Linoleic_Acid'] as dynamic,
      Methionine: json['Methionine'] as dynamic,
      Phosphorus: json['Phosphorus'] as dynamic,
      Niacin: json['Niacin'] as dynamic,
      Zinc: json['Zinc'] as dynamic,
      Calories: json['Calories'] as dynamic,
      Protein: json['Protein'] as dynamic,
      Sodium: json['Sodium'] as dynamic,
      Vitamin_D: json['Vitamin_D'] as dynamic,
      Vitamin_C: json['Vitamin_C'] as dynamic,
      Lysine: json['Lysine'] as dynamic,
      Valine: json['Valine'] as dynamic,
      Vitamin_A: json['Vitamin_A'] as dynamic,
      Fat: json['Fat'] as dynamic,
      Folic_acid: json['Folic_acid'] as dynamic,
      Dietary_Fiber: json['Dietary_Fiber'] as dynamic,
      Vitamin_E: json['Vitamin_E'] as dynamic,
      Vitamin_B6: json['Vitamin_B6'] as dynamic,
      Potassium: json['Potassium'] as dynamic,
      Vitamin_K: json['Vitamin_K'] as dynamic,
      Iso_Leucine: json['Iso_Leucine'] as dynamic,
      Manganese: json['Manganese'] as dynamic,
    );

Map<String, dynamic> _$RDIToJson(RDI instance) => <String, dynamic>{
      'Vitamin_B12': instance.Vitamin_B12,
      'Calcium': instance.Calcium,
      'Iron': instance.Iron,
      'Leucine': instance.Leucine,
      'Histidine': instance.Histidine,
      'Phenylalanine+Tyrosine': instance.Phenylalanine_Tyrosine,
      'Carbohydrate': instance.Carbohydrate,
      'Magnesium': instance.Magnesium,
      'Selenium': instance.Selenium,
      'Copper': instance.Copper,
      'Alpha_Linolenic_Acid': instance.Alpha_Linolenic_Acid,
      'Threonine': instance.Threonine,
      'Linoleic_Acid': instance.Linoleic_Acid,
      'Methionine': instance.Methionine,
      'Phosphorus': instance.Phosphorus,
      'Niacin': instance.Niacin,
      'Zinc': instance.Zinc,
      'Calories': instance.Calories,
      'Protein': instance.Protein,
      'Sodium': instance.Sodium,
      'Vitamin_D': instance.Vitamin_D,
      'Vitamin_C': instance.Vitamin_C,
      'Lysine': instance.Lysine,
      'Valine': instance.Valine,
      'Vitamin_A': instance.Vitamin_A,
      'Fat': instance.Fat,
      'Folic_acid': instance.Folic_acid,
      'Dietary_Fiber': instance.Dietary_Fiber,
      'Vitamin_E': instance.Vitamin_E,
      'Vitamin_B6': instance.Vitamin_B6,
      'Potassium': instance.Potassium,
      'Vitamin_K': instance.Vitamin_K,
      'Iso_Leucine': instance.Iso_Leucine,
      'Manganese': instance.Manganese,
    };

//@JsonSerializable()
class RDI {
  final dynamic Vitamin_B12;
  final dynamic Calcium;
  final dynamic Iron;
  final dynamic Leucine;
  final dynamic Histidine;
  final dynamic Phenylalanine_Tyrosine;
  final dynamic Carbohydrate;
  final dynamic Magnesium;
  final dynamic Selenium;
  final dynamic Copper;
  final dynamic Alpha_Linolenic_Acid;
  final dynamic Threonine;
  final dynamic Linoleic_Acid;
  final dynamic Methionine;
  final dynamic Phosphorus;
  final dynamic Niacin;
  final dynamic Zinc;
  final dynamic Calories;
  final dynamic Protein;
  final dynamic Sodium;
  final dynamic Vitamin_D;
  final dynamic Vitamin_C;
  final dynamic Lysine;
  final dynamic Valine;
  final dynamic Vitamin_A;
  final dynamic Fat;
  final dynamic Folic_acid;
  final dynamic Dietary_Fiber;
  final dynamic Vitamin_E;
  final dynamic Vitamin_B6;
  final dynamic Potassium;
  final dynamic Vitamin_K;
  final dynamic Iso_Leucine;
  final dynamic Manganese;

  RDI({
    required this.Vitamin_B12,
    required this.Calcium,
    required this.Iron,
    required this.Leucine,
    required this.Histidine,
    required this.Phenylalanine_Tyrosine,
    required this.Carbohydrate,
    required this.Magnesium,
    required this.Selenium,
    required this.Copper,
    required this.Alpha_Linolenic_Acid,
    required this.Threonine,
    required this.Linoleic_Acid,
    required this.Methionine,
    required this.Phosphorus,
    required this.Niacin,
    required this.Zinc,
    required this.Calories,
    required this.Protein,
    required this.Sodium,
    required this.Vitamin_D,
    required this.Vitamin_C,
    required this.Lysine,
    required this.Valine,
    required this.Vitamin_A,
    required this.Fat,
    required this.Folic_acid,
    required this.Dietary_Fiber,
    required this.Vitamin_E,
    required this.Vitamin_B6,
    required this.Potassium,
    required this.Vitamin_K,
    required this.Iso_Leucine,
    required this.Manganese,
  });

  factory RDI.fromJson(Map<String, dynamic> json) => _$RDIFromJson(json);
  Map<String, dynamic> toJson() => _$RDIToJson(this);
}
