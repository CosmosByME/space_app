import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';
import 'package:space_app/presentation/theme/colors.dart';

class AppIcons {
  static const String home = 'assets/images/Home.svg';
  static const String alert = 'assets/images/Alert.svg';
  static const String email = 'assets/images/Email.svg';
  static const String google = 'assets/images/Google.svg';
  static const String grid = 'assets/images/Grid.svg';
  static const String inbox = 'assets/images/Inbox.svg';
  static const String info = 'assets/images/Info.svg';
  static const String search = 'assets/images/Search.svg';
  static const String upload = 'assets/images/Upload.svg';
  static const String write = 'assets/images/Write.svg';
  static const String x = 'assets/images/X.svg';
  static const String user = 'assets/images/User.svg';
  static const String paper = 'assets/images/Paper.svg';
  static const String notification = 'assets/images/Notification.svg';
  static const String settings = 'assets/images/Settings.svg';
  static const String add = 'assets/images/Add.svg';
  static const String back = 'assets/images/Chevron Left.svg';
  static const String more = 'assets/images/More.svg';
  static const String send = 'assets/images/Send.svg';
  static const String like = 'assets/images/Like.svg';
  static const String comment = 'assets/images/Comment.svg';
  static const String bookmark = 'assets/images/Bookmark.svg';
  static const String check = 'assets/images/Check.svg';
  static const String media = 'assets/images/Media.svg';
  static const String logo = 'assets/images/logo.svg';

  static SvgPicture get homeIcon =>
      SvgPicture.asset(home, height: 20, width: 20);
  static SvgPicture get alertIcon =>
      SvgPicture.asset(alert, height: 20, width: 20);
  static SvgPicture get emailIcon =>
      SvgPicture.asset(email, height: 20, width: 20);
  static SvgPicture get googleIcon =>
      SvgPicture.asset(google, height: 20, width: 20);
  static SvgPicture get gridIcon =>
      SvgPicture.asset(grid, height: 20, width: 20);
  static SvgPicture get inboxIcon =>
      SvgPicture.asset(inbox, height: 20, width: 20);
  static SvgPicture get infoIcon =>
      SvgPicture.asset(info, height: 20, width: 20);
  static SvgPicture get searchIcon =>
      SvgPicture.asset(search, height: 20, width: 20);
  static SvgPicture get uploadIcon =>
      SvgPicture.asset(upload, height: 20, width: 20);
  static SvgPicture get writeIcon =>
      SvgPicture.asset(write, height: 20, width: 20);
  static SvgPicture get xIcon => SvgPicture.asset(x, height: 20, width: 20);
  static SvgPicture get userIcon =>
      SvgPicture.asset(user, height: 20, width: 20);
  static SvgPicture get paperIcon =>
      SvgPicture.asset(paper, height: 20, width: 20);
  static SvgPicture get notificationIcon =>
      SvgPicture.asset(notification, height: 20, width: 20);
  static SvgPicture get settingsIcon =>
      SvgPicture.asset(settings, height: 20, width: 20);
  static SvgPicture get addIcon => SvgPicture.asset(add, height: 20, width: 20);
  static SvgPicture get backIcon =>
      SvgPicture.asset(back, height: 20, width: 20);
  static SvgPicture get moreIcon =>
      SvgPicture.asset(more, height: 20, width: 20);
  static SvgPicture get sendIcon =>
      SvgPicture.asset(send, height: 20, width: 20);
  static SvgPicture get likeIcon =>
      SvgPicture.asset(like, height: 20, width: 20);
  static SvgPicture get commentIcon =>
      SvgPicture.asset(comment, height: 20, width: 20);
  static SvgPicture get bookmarkIcon =>
      SvgPicture.asset(bookmark, height: 20, width: 20);
  static SvgPicture get checkIcon =>
      SvgPicture.asset(check, height: 20, width: 20);
  static SvgPicture get mediaIcon =>
      SvgPicture.asset(media, height: 20, width: 20);
  static SvgPicture get logoIcon => SvgPicture.asset(
    logo,
    height: 30,
    width: 30,
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(AppColors.primaryB900, BlendMode.srcIn),
  );

  static SvgPicture get homeIconSelected => SvgPicture.asset(
    home,
    height: 24,
    width: 24,
    colorFilter: ColorFilter.mode(AppColors.neutralB900, BlendMode.srcIn),
  );
  static SvgPicture get searchIconSelected => SvgPicture.asset(
    search,
    height: 24,
    width: 24,
    colorFilter: ColorFilter.mode(AppColors.neutralB900, BlendMode.srcIn),
  );
  static SvgPicture get notificationIconSelected => SvgPicture.asset(
    notification,
    height: 24,
    width: 24,
    colorFilter: ColorFilter.mode(AppColors.neutralB900, BlendMode.srcIn),
  );
  static SvgPicture get userIconSelected => SvgPicture.asset(
    user,
    height: 24,
    width: 24,
    colorFilter: ColorFilter.mode(AppColors.neutralB900, BlendMode.srcIn),
  );

  static SvgPicture get homeIconUnSelected => SvgPicture.asset(
    home,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.neutralB300, BlendMode.srcIn),
  );
  static SvgPicture get searchIconUnSelected => SvgPicture.asset(
    search,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.neutralB300, BlendMode.srcIn),
  );
  static SvgPicture get notificationIconUnSelected => SvgPicture.asset(
    notification,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.neutralB300, BlendMode.srcIn),
  );
  static SvgPicture get userIconUnSelected => SvgPicture.asset(
    user,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.neutralB300, BlendMode.srcIn),
  );

  static SvgPicture get likeIconSelected => SvgPicture.asset(
    like,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.primaryB800, BlendMode.srcIn),
  );

  static SvgPicture get bookmarkIconSelected => SvgPicture.asset(
    bookmark,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.primaryB800, BlendMode.srcIn),
  );

  static SvgPicture get settingsIconSelected => SvgPicture.asset(
    settings,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.primaryB800, BlendMode.srcIn),
  );

  static SvgPicture get bookmarkIconUnSelected => SvgPicture.asset(
    bookmark,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.neutralB300, BlendMode.srcIn),
  );

  static SvgPicture get settingsIconUnSelected => SvgPicture.asset(
    settings,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.neutralB300, BlendMode.srcIn),
  );

  static SvgPicture get gridIconSelected => SvgPicture.asset(
    grid,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.primaryB800, BlendMode.srcIn),
  );

  static SvgPicture get gridIconUnSelected => SvgPicture.asset(
    grid,
    height: 22,
    width: 22,
    colorFilter: ColorFilter.mode(AppColors.neutralB300, BlendMode.srcIn),
  );
}
