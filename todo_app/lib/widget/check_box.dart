import 'package:flutter/material.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool isChecked;
  final Function(bool?)? onChanged;
  const CheckBoxWidget(
      {Key? key, required this.isChecked, required this.onChanged})
      : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Checkbox.adaptive(
      key: UniqueKey(),
      activeColor: Colors.black,
      value: widget.isChecked,
      onChanged: widget.onChanged,
    );
  }
}
