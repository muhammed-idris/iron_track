import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';
import 'package:iron_track/features/calories/views/calories_view.dart';
import 'package:iron_track/features/home/views/home_view.dart';
import 'package:iron_track/features/log/views/log_view.dart';
import 'package:iron_track/features/profile/views/profile_view.dart';
import 'package:iron_track/features/progress/views/progress_view.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  static const List<Widget> _pages = [
    HomeView(),
    LogView(),
    CaloriesView(),
    ProgView(),
    ProfileView(),
  ];

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, _pages.length - 1);
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.018),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            labelPadding: EdgeInsets.only(top: height * 0.002),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            indicatorColor: GlassColors.red300.withValues(alpha: 0.16),
            indicatorShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            height: height * 0.075,
            elevation: 0,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            iconTheme: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return const IconThemeData(
                  color: AppColor.primary,
                  size: 24,
                );
              }
              return IconThemeData(
                color: glass.hintText,
                size: 24,
              );
            }),
            labelTextStyle: WidgetStateProperty.resolveWith((states) {
              final isSelected = states.contains(WidgetState.selected);
              return context.text.headline1.copyWith(
                fontSize: isSelected ? 12 : 11,
                color: isSelected ? AppColor.primary : glass.hintText,
              );
            }),
          ),
          child: NavigationBar(
            animationDuration: const Duration(milliseconds: 500),
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onItemTapped,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              NavigationDestination(
                icon: FaIcon(FontAwesomeIcons.dumbbell, size: 20),
                label: 'Workout',
              ),
              NavigationDestination(
                icon: Icon(Icons.local_fire_department),
                label: 'Calories',
              ),
              NavigationDestination(
                icon: Icon(Icons.show_chart),
                label: 'Progress',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
