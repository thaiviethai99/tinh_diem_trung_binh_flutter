
import 'package:flutter/material.dart';

class InputClassWidget extends StatefulWidget {
  final String lableText;
  final String hintText;
  final dynamic controller;
  final dynamic errorText;
  final Function clearMess;

  const InputClassWidget({Key? key, required this.lableText, required this.hintText,required this.controller,required this.errorText, required this.clearMess}) : super(key: key);

  @override
  State<InputClassWidget> createState() => _InputClassWidgetState();
}

class _InputClassWidgetState extends State<InputClassWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: TextField(
          onChanged: (text) {
            widget.clearMess();
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: widget.lableText,
            hintText: widget.hintText,
            errorText: widget.errorText,
          ),
          controller: widget.controller,
        ));
  }
}

class InputClassStateless extends StatelessWidget {
  final String lableText;
  final String hintText;
  final dynamic controller;
  final dynamic errorText;
  final Function clearMess;

  const InputClassStateless({Key? key, required this.lableText, required this.hintText, this.controller, this.errorText, required this.clearMess}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 20),
        child: TextField(
          onChanged: (text) {
            clearMess();
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
}