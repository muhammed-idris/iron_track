import 'package:material_ui/material_ui.dart';
import 'package:iron_track/root/root_screen.dart';
import 'package:iron_track/shared/customs/custom_snack_bar.dart';
import '../logic/auth_routes.dart';
import '../logic/auth_validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_checkbox.dart';
import '../widgets/auth_links.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/password_strength_meter.dart';
import '../widgets/top_icon_widget.dart';
import 'login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!_agreeToTerms) {
      AppSnackBar.error(
        context: context,
        message: 'Please agree to the Terms & Conditions',
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      authFadeRoute(const RootScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      children: [
        const TopIconWidget(),
        Form(
          key: _formKey,
          child: AuthCard(
            title: 'Sign Up',
            subtitle: 'Create an account to start tracking your progress.',
            children: [
              AuthTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person_rounded,
                hintText: 'John Doe',
                keyboardType: TextInputType.name,
                autofillHints: const [AutofillHints.name],
                validator: AuthValidators.name,
              ),
              AuthTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_rounded,
                hintText: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: AuthValidators.email,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthTextField(
                    controller: _passwordController,
                    label: 'Password',
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
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                icon: Icons.lock_rounded,
                hintText: '••••••••',
                obscureText: true,
                autofillHints: const [AutofillHints.newPassword],
                validator: AuthValidators.confirmPassword(
                  () => _passwordController.text,
                ),
              ),
              AuthCheckbox(
                value: _agreeToTerms,
                onChanged: (val) => setState(() => _agreeToTerms = val),
                label: 'I agree to the Terms & Conditions',
              ),
              AuthPrimaryButton(
                text: 'Create Account',
                icon: Icons.check_rounded,
                onTap: _handleSignUp,
              ),
              AuthFooterLink(
                prompt: 'Already have an account?',
                action: 'Log In',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    authFadeRoute(const LoginView()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
