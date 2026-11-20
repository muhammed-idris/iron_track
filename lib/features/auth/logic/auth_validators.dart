import 'package:material_ui/material_ui.dart';

/// Single source of truth for authentication form validations.
abstract final class AuthValidators {
  static final _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? email(String? v) =>
      (v == null || !_emailRegex.hasMatch(v.trim()))
          ? 'Enter a valid email address'
          : null;

  static String? password(String? v) =>
      (v == null || v.length < 8) ? 'Use at least 8 characters' : null;

  static String? name(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Enter your name' : null;

  /// Pass a getter so the validator always compares against the latest password string.
  static FormFieldValidator<String> confirmPassword(
      String Function() original) {
    return (v) {
      if (v == null || v.isEmpty) return 'Confirm your password';
      if (v != original()) return 'Passwords do not match';
      return null;
    };
  }
}
