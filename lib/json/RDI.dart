/////////////// RDI INFO JSON //////////////////
RDI _$RDIFromJson(Map<String, dynamic> json) => RDI(
      Vitamin_B12: json['Vitamin_B12(ug)'] as dynamic ?? 0,
      Calcium: json['Calcium(mg)'] as dynamic ?? 0,
      Iron: json['Iron(mg)'] as dynamic ?? 0,
      Leucine: json['Leucine(g)'] as dynamic ?? 0,
      Histidine: json['Histidine(g)'] as dynamic ?? 0,
      Phenylalanine_Tyrosine: json['Phenylalanine+Tyrosine(g)'] as dynamic ?? 0,
      Carbohydrate: json['Carbohydrate(g)'] as dynamic ?? 0,
      Magnesium: json['Magnesium(mg)'] as dynamic ?? 0,
      Selenium: json['Selenium(ug)'] as dynamic ?? 0,
      Copper: json['Copper(ug)'] as dynamic ?? 0,
      Alpha_Linolenic_Acid: json['Alpha-linolenic_acid(g)'] as dynamic ?? 0,
      Threonine: json['Threonine(g)'] as dynamic ?? 0,
      Linoleic_Acid: json['Linoleic_acid(g)'] as dynamic ?? 0,
      Methionine: json['Methionine(g)'] as dynamic ?? 0,
      Phosphorus: json['Phosphorus(mg)'] as dynamic ?? 0,
      Niacin: json['Niacin(mg)'] as dynamic ?? 0,
      Zinc: json['Zinc(mg)'] as dynamic ?? 0,
      Calories: json['Calories(kcal)'] as dynamic ?? 0,
      Protein: json['Protein(g)'] as dynamic ?? 0,
      Sodium: json['Sodium(mg)'] as dynamic ?? 0,
      Vitamin_D: json['Vitamin_D(ug)'] as dynamic ?? 0,
      Vitamin_C: json['Vitamin_C(mg)'] as dynamic ?? 0,
      Lysine: json['Lysine(g)'] as dynamic ?? 0,
      Valine: json['Valine(g)'] as dynamic ?? 0,
      Vitamin_A: json['Vitamin_A(ug)'] as dynamic ?? 0,
      Fat: json['Fat(g)'] as dynamic ?? 0,
      Folic_acid: json['Folic_acid(ug)'] as dynamic ?? 0,
      Dietary_Fiber: json['Dietary_fiber(g)'] as dynamic ?? 0,
      Vitamin_E: json['Vitamin_E(mg)'] as dynamic ?? 0,
      Vitamin_B6: json['Vitamin_B6(mg)'] as dynamic ?? 0,
      Potassium: json['Potassium(mg)'] as dynamic ?? 0,
      Vitamin_K: json['Vitamin_K(ug)'] as dynamic ?? 0,
      Iso_Leucine: json['Isoleucine(g)'] as dynamic ?? 0,
      Manganese: json['Manganese(mg)'] as dynamic ?? 0,
      Tryptophan: json['Tryptophan(g)'] as dynamic ?? 0,
      Vitamin_B1: json['Vitamin_B1(mg)'] as dynamic ?? 0,
      Vitamin_B2: json['Vitamin_B2(mg)'] as dynamic ?? 0,
      Pantothenic_acid: json['Pantothenic_acid(mg)'] as dynamic ?? 0,
      Chloride: json['Chloride(mg)'] as dynamic ?? 0,
      Iodine: json['Iodine(ug)'] as dynamic ?? 0,
      Biotin: json['Biotin(ug)'] as dynamic ?? 0,
      EPA_DHA: json['EPA+DHA(mg)'] as dynamic ?? 0,
    );

Map<String, dynamic> _$RDIToJson(RDI instance) => <String, dynamic>{
      'Vitamin_B12(ug)': instance.Vitamin_B12,
      'Calcium(mg)': instance.Calcium,
      'Iron(mg)': instance.Iron,
      'Leucine(g)': instance.Leucine,
      'Histidine(g)': instance.Histidine,
      'Phenylalanine+Tyrosine(g)': instance.Phenylalanine_Tyrosine,
      'Carbohydrate(g)': instance.Carbohydrate,
      'Magnesium(mg)': instance.Magnesium,
      'Selenium(ug)': instance.Selenium,
      'Copper(ug)': instance.Copper,
      'Alpha-linolenic_acid(g)': instance.Alpha_Linolenic_Acid,
      'Threonine(g)': instance.Threonine,
      'Linoleic_acid(g)': instance.Linoleic_Acid,
      'Methionine(g)': instance.Methionine,
      'Phosphorus(mg)': instance.Phosphorus,
      'Niacin(mg)': instance.Niacin,
      'Zinc(mg)': instance.Zinc,
      'Calories(kcal)': instance.Calories,
      'Protein(g)': instance.Protein,
      'Sodium(mg)': instance.Sodium,
      'Vitamin_D(ug)': instance.Vitamin_D,
      'Vitamin_C(mg)': instance.Vitamin_C,
      'Lysine(g)': instance.Lysine,
      'Valine(g)': instance.Valine,
      'Vitamin_A(ug)': instance.Vitamin_A,
      'Fat(g)': instance.Fat,
      'Folic_acid(ug)': instance.Folic_acid,
      'Dietary_fiber(g)': instance.Dietary_Fiber,
      'Vitamin_E(mg)': instance.Vitamin_E,
      'Vitamin_B6(mg)': instance.Vitamin_B6,
      'Potassium(mg)': instance.Potassium,
      'Vitamin_K(ug)': instance.Vitamin_K,
      'Isoleucine(g)': instance.Iso_Leucine,
      'Manganese(mg)': instance.Manganese,
      'Tryptophan(g)': instance.Tryptophan,
      'Vitamin_B1(mg)': instance.Vitamin_B1,
      'Vitamin_B2(mg)': instance.Vitamin_B2,
      'Pantothenic_acid(mg)': instance.Pantothenic_acid,
      'Chloride(mg)': instance.Chloride,
      'Biotin(ug)': instance.Biotin,
      'Iodine(ug)': instance.Iodine,
      'EPA+DHA(mg)': instance.EPA_DHA,
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
  final dynamic Tryptophan;
  final dynamic Vitamin_B1;
  final dynamic Vitamin_B2;
  final dynamic Pantothenic_acid;
  final dynamic Chloride;
  final dynamic Iodine;
  final dynamic Biotin;
  final dynamic EPA_DHA;

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
    required this.Tryptophan,
    required this.Vitamin_B1,
    required this.Vitamin_B2,
    required this.Pantothenic_acid,
    required this.Chloride,
    required this.Iodine,
    required this.Biotin,
    required this.EPA_DHA,
  });

  factory RDI.fromJson(Map<String, dynamic> json) => _$RDIFromJson(json);
  Map<String, dynamic> toJson() => _$RDIToJson(this);
}
