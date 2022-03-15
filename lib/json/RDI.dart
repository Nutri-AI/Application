/////////////// RDI INFO JSON //////////////////

RDI _$RDIFromJson(Map<String, dynamic> json) => RDI(
      Vitamin_B12: json['Vitamin_B12'] as double,
      Calcium: json['Calcium'] as double,
      Iron: json['Iron'] as double,
      Leucine: json['Leucine'] as double,
      Histidine: json['Histidine'] as double,
      Phenylalanine_Tyrosine: json['Phenylalanine+Tyrosine'] as double,
      Carbohydrate: json['Carbohydrate'] as double,
      Magnesium: json['Magnesium'] as double,
      Selenium: json['Selenium'] as double,
      Copper: json['Copper'] as double,
      Alpha_Linolenic_Acid: json['Alpha_Linolenic_Acid'] as double,
      Threonine: json['Threonine'] as double,
      Linoleic_Acid: json['Linoleic_Acid'] as double,
      Methionine: json['Methionine'] as double,
      Phosphorus: json['Phosphorus'] as double,
      Niacin: json['Niacin'] as double,
      Zinc: json['Zinc'] as double,
      Calories: json['Calories'] as double,
      Protein: json['Protein'] as double,
      Sodium: json['Sodium'] as double,
      Vitamin_D: json['Vitamin_D'] as double,
      Vitamin_C: json['Vitamin_C'] as double,
      Lysine: json['Lysine'] as double,
      Valine: json['Valine'] as double,
      Vitamin_A: json['Vitamin_A'] as double,
      Fat: json['Fat'] as double,
      Folic_acid: json['Folic_acid'] as double,
      Dietary_Fiber: json['Dietary_Fiber'] as double,
      Vitamin_E: json['Vitamin_E'] as double,
      Vitamin_B6: json['Vitamin_B6'] as double,
      Potassium: json['Potassium'] as double,
      Vitamin_K: json['Vitamin_K'] as double,
      Iso_Leucine: json['Iso_Leucine'] as double,
      Manganese: json['Manganese'] as double,
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
  final double Vitamin_B12;
  final double Calcium;
  final double Iron;
  final double Leucine;
  final double Histidine;
  final double Phenylalanine_Tyrosine;
  final double Carbohydrate;
  final double Magnesium;
  final double Selenium;
  final double Copper;
  final double Alpha_Linolenic_Acid;
  final double Threonine;
  final double Linoleic_Acid;
  final double Methionine;
  final double Phosphorus;
  final double Niacin;
  final double Zinc;
  final double Calories;
  final double Protein;
  final double Sodium;
  final double Vitamin_D;
  final double Vitamin_C;
  final double Lysine;
  final double Valine;
  final double Vitamin_A;
  final double Fat;
  final double Folic_acid;
  final double Dietary_Fiber;
  final double Vitamin_E;
  final double Vitamin_B6;
  final double Potassium;
  final double Vitamin_K;
  final double Iso_Leucine;
  final double Manganese;

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
