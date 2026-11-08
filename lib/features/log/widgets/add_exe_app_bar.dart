import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import '../../../shared/containers/crystal_container.dart';
import '../../../shared/containers/info_divider.dart';

class AddExeAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AddExeAppBar({
    super.key,required this.appBarTitle,
  });

  final String appBarTitle;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final glass = context.glass;

    return AppBar(
      toolbarHeight: 80,
      leading: Padding(
        padding: EdgeInsets.only(top:height * 0.02 ),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: CustomGlassCard(
            margin: EdgeInsets.only(bottom: height * 0.01),
            padding: EdgeInsets.zero,
            height: height * 0.1,
            borderRadius: 15,
            gradient: LinearGradient(
              colors: glass.surfaceGradient,
            ),
            borderColors: glass.borderColors,
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: glass.copyColor,
              ),
            ),
          ),
        ),
      ),

      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Text(
              appBarTitle,
              style: context.text.appBar.copyWith(
                color: glass.textPrimary,
              ),
            ),
            const Gap(7),
            InfoDivider(
              margin: 10,
              color: glass.textMuted,
              width: width * .35,
              height: height * .005,
              topLeft: 30,
              topRight: 30,
              bottomLeft: 30,
              bottomRight: 30,
            )
          ],
        ),
      ),

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
    );
  }
}

