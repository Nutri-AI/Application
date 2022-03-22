import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Inference extends StatefulWidget {
  Inference({Key? key}) : super(key: key);

  @override
  State<Inference> createState() => _InferenceState();
}

class _InferenceState extends State<Inference> {
  List class_type = ["비빔밥", "김치찌개"];
  List food_list = [
    ["돌솥비빔밥", "멍게비빔밥", "비빔밥", "약초비빔밥", "육회비빔밥"],
    ["김치찌개", "돼지김치찌개", "꽁치김치찌개", "참치김치찌개"]
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              for (int i = 0; i < class_type.length; i++) Text(class_type[i])
            ],
          ),
        ),
      ),
    );
  }
}
