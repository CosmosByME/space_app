import 'package:flutter/material.dart';
import 'package:space_app/presentation/components/icons.dart';
import 'package:space_app/presentation/theme/colors.dart';

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: Row(
        children: [
          AppIcons.alertIconWhite,
          SizedBox(width: 10),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
      backgroundColor: AppColors.semanticR900,
    ),
  );
}

void showSuccessSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: Row(
        children: [
          AppIcons.checkIconWhite,
          SizedBox(width: 10),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
      backgroundColor: AppColors.semanticG900,
    ),
  );
}

void showWarningSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      showCloseIcon: true,
      closeIconColor: Colors.white,
      content: Row(
        children: [
          AppIcons.infoIconWhite,
          SizedBox(width: 10),
          Text(message, style: TextStyle(color: Colors.white)),
        ],
      ),
      backgroundColor: AppColors.semanticY900,
    ),
  );
}
