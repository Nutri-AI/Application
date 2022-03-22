import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Inference extends StatefulWidget {
  String uri;
  List<dynamic>? subcat;
  String s3Key;
  List<dynamic>? classCat;

  Inference(
      {Key? key,
      required this.uri,
      this.subcat,
      required this.s3Key,
      this.classCat})
      : super(key: key);

  @override
  State<Inference> createState() => _InferenceState();
}

class _InferenceState extends State<Inference> {
  late String url;
  late List<dynamic>? foodList;
  late String key;
  late List<dynamic>? classType;
  String? dropdownValue;

  @override
  void initState() {
    url = widget.uri;
    foodList = widget.subcat;
    key = widget.s3Key;
    classType = widget.classCat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Image.network(
                url,
                width: 400,
                height: 400,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < classType!.length; i++)
                    Text(
                      classType![i] + '의 세부카테고리: ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < classType!.length; i++)
                    DropdownButton<String>(
                      //
                      value: dropdownValue = foodList![i][0],
                      icon: const Icon(Icons.arrow_downward),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: foodList![i]
                          .map<DropdownMenuItem<dynamic>>((dynamic value) {
                        return DropdownMenuItem<dynamic>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
