import 'package:flutter/material.dart';

import 'input_class_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ứng dụng Xếp loại học lực',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ứng dụng Xếp loại học lực'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _errorMessToan = 'Chưa nhập điểm môn Toán';
  String _errorMessVan = 'Chưa nhập điểm môn Văn';
  String _errorMessAnh = 'Chưa nhập điểm môn Anh';
  var _isErrorToan = false;
  var _isErrorVan = false;
  var _isErrorAnh = false;

  double? scoreResult;
  String xepLoaiHocLuc = '';
  var _isShowResult = false;

  final TextEditingController toanController = TextEditingController(text: '');
  final TextEditingController vanController = TextEditingController(text: '');
  final TextEditingController anhController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
          child: Column(
            children: [
              InputClassWidget(
                  lableText: "Điểm môn Toán",
                  hintText: "Nhập điểm toán",
                  controller: toanController,
                  clearMess: (){
                    setState(() {
                      _isErrorToan = false;
                    });
                  },
                  errorText: _isErrorToan ? _errorMessToan : null),
              // Textfield : Năm sinh
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: tinhDiem,
                      child: const Text("Tính điểm trung bình")),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.redAccent),
                      onPressed: clearInput,
                      child: const Text("Clear Input"))
                ],
              ),
              _isShowResult ? showCardResult() : Container()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox showCardResult() {
    return SizedBox(
      width: 300,
      height: 200,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.green[100],
        shadowColor: Colors.blueGrey,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(" Điểm trung bình : ${scoreResult?.toStringAsFixed(2) ?? ''}"),
            Text(" Xếp loại : ${xepLoaiHocLuc.toString()}"),
          ],
        ),
      ),
    );
  }

  Widget inputWidget(
      {required String lableText,
      required String hintText,
      required controller,
      required var errorText,
      required Function clearMess}) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: TextField(
          onChanged: (text) {
            setState(() {
              // if (clearMess == 1) {
              //   _isErrorToan = false;
              // }

              // if (clearMess == 2) {
              //   _isErrorVan = false;
              // }

              // if (clearMess == 3) {
              //   _isErrorAnh = false;
              // }
              clearMess();
            });
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: lableText,
            hintText: hintText,
            errorText: errorText,
          ),
          controller: controller,
        ));
  }

  double mediumScore(
      {required double scoreToan,
      required double scoreVan,
      required double scoreAnh}) {
    return (scoreToan + scoreVan + scoreAnh) / 3;
  }

  String xepLoai({required double diemTB}) {
    var result = '';
    if (diemTB >= 9) {
      result = "Xuất sắc";
    } else if (diemTB >= 8) {
      result = ("Giỏi");
    } else if (diemTB >= 7) {
      result = "Khá";
    } else if (diemTB >= 6) {
      result = "Trung bình khá";
    } else if (diemTB >= 5) {
      result = "Trung bình";
    } else {
      result = "Yếu";
    }

    return result;
  }

  bool isNumericUsingRegularExpression(String string) {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

    return numericRegex.hasMatch(string);
  }

  void tinhDiem() {
    setState(() {
      var diemToan = toanController.text;

      if (diemToan.isEmpty) {
        _isErrorToan = true;
        _errorMessToan = 'Chưa nhập điểm môn Toán';
        return;
      }
    });
  }

  void clearInput() {
    vanController.clear();
    toanController.clear();
    anhController.clear();
    setState(() {
      _isShowResult = false;
    });
  }
}
