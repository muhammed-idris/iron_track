import 'package:material_ui/material_ui.dart';
import '../logic/auth_routes.dart';
import '../logic/auth_validators.dart';
import '../widgets/auth_card.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_from_field.dart';
import '../widgets/top_icon_widget.dart';
import 'forget_pass_code_view.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSendCode() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        authFadeRoute(const ForgetPassCodeView()),
      );
    }
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
            title: 'Reset Password',
            subtitle: 'Enter your account email to receive a verification code.',
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
              AuthPrimaryButton(
                text: 'Send Verification Code',
                onTap: _handleSendCode,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
