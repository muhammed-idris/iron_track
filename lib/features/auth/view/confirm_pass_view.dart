import 'package:material_ui/material_ui.dart';
import 'package:iron_track/shared/customs/custom_snack_bar.dart';
import '../logic/auth_routes.dart';
import '../logic/auth_validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/password_strength_meter.dart';
import '../widgets/top_icon_widget.dart';
import 'login_view.dart';

class ConfirmPassView extends StatefulWidget {
  const ConfirmPassView({super.key});

  @override
  State<ConfirmPassView> createState() => _ConfirmPassViewState();
}

class _ConfirmPassViewState extends State<ConfirmPassView> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _handleResetPassword() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    AppSnackBar.success(
      context: context,
      message: 'Password updated successfully',
    );

    Navigator.of(context).pushAndRemoveUntil(
      authFadeRoute(const LoginView()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBack: true,
      children: [
        const TopIconWidget(),
        Form(
          key: _formKey,
          child: AuthCard(
            title: 'Set New Password',
            subtitle: 'Choose a strong new password for your account.',
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextField(
                    controller: _passwordController,
                    label: 'New Password',
                    icon: Icons.lock_rounded,
                    hintText: '••••••••',
                    obscureText: true,
                    autofillHints: const [AutofillHints.newPassword],
                    validator: AuthValidators.password,
                  ),
                  PasswordStrengthMeter(controller: _passwordController),
                ],
              ),
              AuthTextField(
                controller: _confirmController,
                label: 'Confirm Password',
                icon: Icons.lock_rounded,
                hintText: '••••••••',
                obscureText: true,
                autofillHints: const [AutofillHints.newPassword],
                validator: AuthValidators.confirmPassword(
                  () => _passwordController.text,
                ),
              ),
              AuthPrimaryButton(
                text: 'Save Password',
                onTap: _handleResetPassword,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
