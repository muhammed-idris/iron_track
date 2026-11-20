import 'package:material_ui/material_ui.dart';
import 'package:iron_track/core/constants/colors_manager.dart';
import 'package:iron_track/root/root_screen.dart';
import '../logic/auth_routes.dart';
import '../logic/auth_validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_checkbox.dart';
import '../widgets/auth_links.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/social_auth_section.dart';
import '../widgets/top_icon_widget.dart';
import 'forget_password_view.dart';
import 'sign_up_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacement(
        context,
        authFadeRoute(const RootScreen()),
      );
    }
  }

  void _handleGuestLogin() {
    FocusScope.of(context).unfocus();
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
            title: 'Login',
            subtitle: 'Welcome back! Enter your details below.',
            children: [
              AuthTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_rounded,
                hintText: 'you@example.com',
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
                validator: AuthValidators.email,
              ),
              AuthTextField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock_rounded,
                hintText: '••••••••',
                obscureText: true,
                autofillHints: const [AutofillHints.password],
                validator: AuthValidators.password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AuthCheckbox(
                    value: _rememberMe,
                    onChanged: (val) => setState(() => _rememberMe = val),
                    label: 'Remember Me',
                  ),
                  AuthTextLink(
                    text: 'Forgot Password?',
                    onTap: () {
                      Navigator.push(
                        context,
                        authFadeRoute(const ForgetPasswordView()),
                      );
                    },
                  ),
                ],
              ),
              AuthPrimaryButton(
                text: 'Login',
                onTap: _handleLogin,
              ),
              const OrDivider(label: 'Or continue with'),
              const ContinueWithButton(),
              AuthFooterLink(
                prompt: "Don't have an account?",
                action: 'Sign Up',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    authFadeRoute(const SignUpView()),
                  );
                },
              ),
              Center(
                child: AuthTextLink(
                  text: 'Continue as Guest',
                  color: AppColor.primary,
                  onTap: _handleGuestLogin,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
