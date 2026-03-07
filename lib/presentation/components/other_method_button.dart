import 'package:flutter/material.dart';
import 'package:space_app/presentation/theme/colors.dart';

class OtherMethodsButton extends StatelessWidget {
  final Widget icon;
  final String text;
  const OtherMethodsButton({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.neutralB100),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon,
          SizedBox(width: 14),
          Text(
            text,
            style: TextStyle(fontSize: 17, color: AppColors.neutralB400),
          ),
        ],
      ),
    );
  }
}
