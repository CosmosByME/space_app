import 'package:flutter/material.dart';
import 'package:space_app/presentation/theme/colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.neutralB100),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
