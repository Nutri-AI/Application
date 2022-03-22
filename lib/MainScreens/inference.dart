import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Inference extends StatefulWidget {
  Inference({Key? key}) : super(key: key);

  @override
  State<Inference> createState() => _InferenceState();
}

class _InferenceState extends State<Inference> {
  @override
  // List class_type = ["비빔밥", "김치찌개"];
  // List food_list = [
  //   ["돌솥비빔밥", "멍게비빔밥", "비빔밥", "약초비빔밥", "육회비빔밥"],
  //   ["김치찌개", "돼지김치찌개", "꽁치김치찌개", "참치김치찌개"]
  // ];

  // void getMenu(){
  //   for (int i=0; i < class_type.length; i++){
  //     String menu_class = class_type[i];
  //     List menu_list = food_list[i];
  //     String dropdownvalue = menu_class;
  //     DropdownButton(
  //                   value: dropdownvalue,
  //                   icon: const Icon(Icons.arrow_downward_rounded),
  //                   elevation: 0,
  //                 onChanged: (String? newValue){
  //                   setState(() {
  //                     dropdownvalue = newValue!;
  //                   });
  //                 },
  //                 items: menu_list
  //                 .map<DropdownMenuItem<String>>((String value) {
  //                   return DropdownMenuItem<String>(
  //                     value: value,
  //                     child: Text(value),
  //                   );
  //                 }).toList(),
  //               ),
  //   }
  // }

  Widget build(BuildContext context) {
    List class_type = ["비빔밥", "김치찌개"];
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (var i = 0; i < class_type.length; i++) Text(class_type[i]),
            ],
          ),
        ),
      ),
    );
  }
}
