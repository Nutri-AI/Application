import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Inference extends StatefulWidget {
  Inference({Key? key}) : super(key: key);

  @override
  State<Inference> createState() => _InferenceState();
}

class _InferenceState extends State<Inference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Text("웰컴!!!!!!!!"),
      ),
    );
  }
}
