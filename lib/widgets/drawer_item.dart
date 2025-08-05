import 'package:flutter/material.dart';
import '../models/drawer_config.dart';

/// A custom drawer item widget
class DrawerItem extends StatelessWidget {
  final DrawerItemConfig config;

  const DrawerItem({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    if (config.isDivider) {
      return const Divider();
    }

    return ListTile(
      leading: Icon(config.icon),
      title: Text(config.title),
      trailing: config.trailing,
      onTap: config.onTap,
      dense: true,
    );
  }
}
