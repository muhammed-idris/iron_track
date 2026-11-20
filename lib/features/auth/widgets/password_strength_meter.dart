import 'package:material_ui/material_ui.dart';
import 'package:gap/gap.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/core/theme/theme_context.dart';

/// Four-segment password strength meter.
class PasswordStrengthMeter extends StatelessWidget {
  const PasswordStrengthMeter({super.key, required this.controller});

  final TextEditingController controller;

  static const _labels = ['Weak', 'Fair', 'Good', 'Strong'];

  static int _score(String pw) {
    var score = 0;
    if (pw.length >= 8) score++;
    if (pw.contains(RegExp(r'[a-z]')) && pw.contains(RegExp(r'[A-Z]'))) score++;
    if (pw.contains(RegExp(r'\d'))) score++;
    if (pw.length >= 12 || pw.contains(RegExp(r'[^A-Za-z0-9]'))) score++;
    return score < 1 ? 1 : score;
  }

  @override
  Widget build(BuildContext context) {
    final glass = context.glass;
    final colors = [
      AppColor.danger,
      Colors.orange,
      Colors.amber,
      Colors.green,
    ];

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final pw = value.text;
        final level = _score(pw);
        final color = colors[level - 1];

        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          alignment: Alignment.topCenter,
          child: pw.isEmpty
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (var i = 0; i < 4; i++) ...[
                            if (i > 0) const Gap(4),
                            Expanded(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 220),
                                height: 4,
                                decoration: BoxDecoration(
                                  color: i < level ? color : glass.mutedBorder,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const Gap(6),
                      Text(
                        _labels[level - 1],
                        style: context.text.bodySmall.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
