enum CredentialFailure { emptyEmail, invalidEmail, emptyPassword, shortPassword }

abstract final class CredentialValidator {
  static const int minPasswordLength = 8;

  static final RegExp _emailShape = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static CredentialFailure? email(String value) {
    final String email = value.trim();
    if (email.isEmpty) {
      return CredentialFailure.emptyEmail;
    }
    return _emailShape.hasMatch(email) ? null : CredentialFailure.invalidEmail;
  }

  static CredentialFailure? password(String value) {
    return value.isEmpty ? CredentialFailure.emptyPassword : null;
  }

  static CredentialFailure? newPassword(String value) {
    if (value.isEmpty) {
      return CredentialFailure.emptyPassword;
    }
    return value.length < minPasswordLength ? CredentialFailure.shortPassword : null;
  }
}
