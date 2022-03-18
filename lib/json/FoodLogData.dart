import 'RDI.dart';

FoodLogData _$FoodLogDataFromJson(Map<String, dynamic> json) => FoodLogData(
      meal: json['MEAL'] as List<dynamic>,
      nutrStatus: RDI.fromJson((json['nutr_status'] ??
          noLogToday['nutr_status']) as Map<String, dynamic>),
      rdi: RDI.fromJson(json['RDI'] as Map<String, dynamic>),
      username: json['username'] as String,
    );

Map<String, dynamic> _$FoodLogDataToJson(FoodLogData instance) =>
    <String, dynamic>{
      'MEAL': instance.meal.toList(),
      'RDI': instance.rdi.toJson(),
      'nutr_status': instance.nutrStatus.toJson(),
      'username': instance.username,
    };

class FoodLogData {
  final String username;
  RDI nutrStatus;
  RDI rdi;
  List<dynamic> meal;

  FoodLogData({
    required this.username,
    required this.rdi,
    required this.nutrStatus,
    required this.meal,
  });

  factory FoodLogData.fromJson(Map<String, dynamic> json) =>
      _$FoodLogDataFromJson(json);
  Map<String, dynamic> toJson() => _$FoodLogDataToJson(this);
}

Map<String, dynamic> noLogToday = {
  "nutr_status": {"Calories": 0, "Carbohydrate": 0, "Protein": 0, "Fat": 0}
};
