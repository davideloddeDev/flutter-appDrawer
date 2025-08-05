import 'package:flutter/material.dart';
import '../models/drawer_config.dart';
import 'drawer_item.dart';

/// A customizable app drawer widget
class CustomAppDrawer extends StatelessWidget {
  final DrawerConfig config;

  const CustomAppDrawer({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(context, config),
          ...config.items.map((item) => DrawerItem(config: item)),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context, DrawerConfig config) {
    if (config.customHeader != null) {
      return config.customHeader!;
    }

    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: config.headerGradient ??
            LinearGradient(
              colors: [
                config.headerBackgroundColor ?? Theme.of(context).primaryColor,
                (config.headerBackgroundColor ?? Theme.of(context).primaryColor)
                    .withValues(alpha: 0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: config.userAvatarUrl != null
                ? NetworkImage(config.userAvatarUrl!)
                : null,
            child: config.userAvatarUrl == null
                ? const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  )
                : null,
          ),
          const SizedBox(height: 10),
          if (config.userName != null)
            Text(
              config.userName!,
              style: config.userNameStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          if (config.userEmail != null)
            Text(
              config.userEmail!,
              style: config.userEmailStyle ??
                  TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
            ),
        ],
      ),
    );
  }
}
