import 'package:flutter/material.dart';
import 'package:iron_track/core/theme/theme_context.dart';

class LogAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const LogAppBar({super.key, required this.title});

  static const double _height = 90;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  State<LogAppBar> createState() => _LogAppBarState();
}

class _LogAppBarState extends State<LogAppBar> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final glass = context.glass;

    return AppBar(
      toolbarHeight: LogAppBar._height,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: context.text.appBar.copyWith(color: glass.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Text(
                      'Track. Compete. ',
                      style: context.text.subtitle.copyWith(color: glass.hintText),
                    ),
                    Text(
                      'Dominate',
                      style: context.text.subtitle.copyWith(color: glass.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}