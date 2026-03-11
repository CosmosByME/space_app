import 'package:flutter/material.dart';
import 'package:space_app/presentation/theme/colors.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.text,
  });

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isVisible = false;
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
        textAlignVertical: TextAlignVertical.center,
        obscureText: !isVisible,
        controller: widget.controller,
        decoration: InputDecoration(
          isCollapsed: false,
          isDense: false,
          hintText: widget.text,
          border: InputBorder.none,
          suffix: SizedBox(height: 2),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            icon: isVisible
                ? Icon(Icons.visibility_off_rounded)
                : Icon(Icons.visibility_rounded),
          ),
        ),
      ),
    );
  }
}
