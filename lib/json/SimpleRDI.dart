SimpleRDI _$SimpleRDIFromJson(Map<String, int> json) => SimpleRDI(
      Carbohydrate: json['Carbohydrate'] as int,
      Calories: json['Calories'] as int,
      Protein: json['Protein'] as int,
      Fat: json['Fat'] as int,
    );

Map<String, dynamic> _$SimpleRDIToJson(SimpleRDI instance) => <String, int>{
      'Carbohydrate': instance.Carbohydrate,
      'Calories': instance.Calories,
      'Protein': instance.Protein,
      'Fat': instance.Fat,
    };

//@JsonSerializable()
class SimpleRDI {
  final int Carbohydrate;
  final int Calories;
  final int Protein;
  final int Fat;

  SimpleRDI({
    required this.Calories,
    required this.Protein,
    required this.Fat,
    required this.Carbohydrate,
  });

  factory SimpleRDI.fromJson(Map<String, int> json) =>
      _$SimpleRDIFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleRDIToJson(this);
}
