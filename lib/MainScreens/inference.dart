import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Inference extends StatefulWidget {
  String uri;
  List<dynamic>? subcat;
  Inference({Key? key, required this.uri, this.subcat}) : super(key: key);

  @override
  State<Inference> createState() => _InferenceState();
}

class _InferenceState extends State<Inference> {
  late String url;
  late List<dynamic>? foodList;

  @override
  void initState() {
    url = widget.uri;
    foodList = widget.subcat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text(url)),
    );
  }
}
