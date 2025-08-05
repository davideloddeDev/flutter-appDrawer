import 'package:flutter/material.dart';

/// Configuration class for customizing the app drawer
class DrawerConfig {
  final String? userName;
  final String? userEmail;
  final String? userAvatarUrl;
  final Widget? customHeader;
  final List<DrawerItemConfig> items;
  final Color? headerBackgroundColor;
  final Gradient? headerGradient;
  final TextStyle? userNameStyle;
  final TextStyle? userEmailStyle;

  const DrawerConfig({
    this.userName,
    this.userEmail,
    this.userAvatarUrl,
    this.customHeader,
    this.items = const [],
    this.headerBackgroundColor,
    this.headerGradient,
    this.userNameStyle,
    this.userEmailStyle,
  });
}

/// Configuration for individual drawer items
class DrawerItemConfig {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool isDivider;

  const DrawerItemConfig({
    this.icon = Icons.menu,
    required this.title,
    this.onTap,
    this.trailing,
    this.isDivider = false,
  });

  /// Creates a divider item
  const DrawerItemConfig.divider()
      : icon = Icons.menu,
        title = '',
        onTap = null,
        trailing = null,
        isDivider = true;
}
