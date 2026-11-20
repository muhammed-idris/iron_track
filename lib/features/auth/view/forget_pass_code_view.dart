import 'package:material_ui/material_ui.dart';
import 'package:iron_track/shared/customs/custom_snack_bar.dart';
import '../logic/auth_routes.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/otp_input.dart';
import '../widgets/top_icon_widget.dart';
import 'confirm_pass_view.dart';

class ForgetPassCodeView extends StatefulWidget {
  const ForgetPassCodeView({super.key});

  @override
  State<ForgetPassCodeView> createState() => _ForgetPassCodeViewState();
}

class _ForgetPassCodeViewState extends State<ForgetPassCodeView> {
  final _otpController = TextEditingController();
  bool _hasError = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    final code = _otpController.text.trim();
    if (code.length < 5) {
      setState(() => _hasError = true);
      AppSnackBar.error(
        context: context,
        message: 'Please enter the 5-digit verification code',
      );
      return;
    }

    setState(() => _hasError = false);
    Navigator.push(
      context,
      authFadeRoute(const ConfirmPassView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: true,
      children: [
        const TopIconWidget(),
        AuthCard(
          title: 'Verify Code',
          subtitle: 'Enter the 5-digit code sent to your email.',
          children: [
            OtpInput(
              controller: _otpController,
              length: 5,
              hasError: _hasError,
              autofocus: true,
              onCompleted: (_) => _handleConfirm(),
            ),
            AuthPrimaryButton(
              text: 'Confirm Code',
              onTap: _handleConfirm,
            ),
          ],
        ),
      ],
    );
  }
}
