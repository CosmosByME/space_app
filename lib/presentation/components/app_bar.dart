import 'package:flutter/material.dart';
import 'package:space_app/presentation/components/icons.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({super.key})
    : super(
        title: LogoContainer(),
        centerTitle: false,
        actionsPadding: EdgeInsets.only(right: 24, top: 17, bottom: 17),
        actions: [GestureDetector(child: AppIcons.sendIcon)],
      );
}

class LogoContainer extends StatelessWidget {
  const LogoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcons.logoIcon,
          Text(
            'StellarHub',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
