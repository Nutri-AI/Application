import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:demo/MainScreens/inference.dart';

class ImagePickerTest extends StatefulWidget {
  String email;
  ImagePickerTest({Key? key, required this.email}) : super(key: key);

  @override
  State<ImagePickerTest> createState() => _ImagePickerTestState();
}

class _ImagePickerTestState extends State<ImagePickerTest> {
  late String userid;
  File? image;
  late dynamic url;

  @override
  void initState() {
    userid = widget.email;
    super.initState();
  }

  // Future<String> uploadImg(File? image, String userid) async {
  //   String result = '';
  //   String baseUrl = 'http://10.0.2.2:8000/log/upload/image/';
  //   var uri = Uri.parse(baseUrl + userid);
  //   var request = http.MultipartRequest('POST', uri);
  //   Map<String, String> headers = {"Content-type": "multipart/form-data"};
  //   request.files.add(http.MultipartFile(
  //     'image',
  //     image!.readAsBytes().asStream(),
  //     image.lengthSync(),
  //     filename: "${userid}/${DateFormat.yMd().add_jm().format(DateTime.now())}",
  //   ));
  //   request.headers.addAll(headers);
  //   print("request: " + request.toString());

  //   var response = await request.send();
  //   result = await response.stream.bytesToString();
  //   // var response = Streamedresponse.stream.bytesToString();
  //   // response.stream.transform(utf8.decoder).listen((value) {
  //   //   result = value;
  //   // });
  //   return result;
  // }

  Future<dynamic> predictImg(String userid) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      } else {
        final imageTemporary = File(image.path);
        // setState(() => this.image = imageTemporary);

        String result = '';
        // String baseUrl = 'http://10.0.2.2:8000/log/upload/image/'; // 혜원
        String baseUrl = 'http://192.168.1.98:8000/log/upload/image/'; // 영우
        var uri = Uri.parse(baseUrl + userid);
        var request = http.MultipartRequest('POST', uri);
        Map<String, String> headers = {"Content-type": "multipart/form-data"};
        request.files.add(http.MultipartFile(
          'image',
          imageTemporary.readAsBytes().asStream(),
          imageTemporary.lengthSync(),
          filename:
              "${userid}/${DateFormat.yMd().add_jm().format(DateTime.now())}",
        ));
        request.headers.addAll(headers);
        print("request: " + request.toString());

        var response = await request.send();
        result = await response.stream.bytesToString();
        // var response = Streamedresponse.stream.bytesToString();
        // response.stream.transform(utf8.decoder).listen((value) {
        //   result = value;
        // });
        return result;
      }
    } on PlatformException catch (e) {
      // Don't allow access to photos
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 30, right: 30),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            const Text("Show me Selected Photo!"),
            image != null
                ? Image.network(
                    url,
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  )
                : const FlutterLogo(size: 160),
            // ElevatedButton(
            //   onPressed: () async {
            //     dynamic res = await uploadImg(image, userid);

            //     print(jsonDecode(res)['link']);
            //   },
            //   child: const Text(
            //     "Upload",
            //     style: TextStyle(color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          dynamic res = await predictImg(userid);
          url = jsonDecode(res)['link'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Inference(),
            ),
          );
        },
        child: Icon(
          Icons.add_a_photo,
          color: Colors.green[600],
        ),
      ),
    );
  }
}
