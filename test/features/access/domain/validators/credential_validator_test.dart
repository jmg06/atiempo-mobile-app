import 'package:atiempo_mobile_app/features/access/domain/validators/credential_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('email', () {
    test('accepts the prefilled address', () {
      expect(CredentialValidator.email('carlos.restrepo@correo.com'), isNull);
    });

    test('ignores surrounding spaces', () {
      expect(CredentialValidator.email('  carlos.restrepo@correo.com '), isNull);
    });

    test('asks for it when empty', () {
      expect(CredentialValidator.email('   '), CredentialFailure.emptyEmail);
    });

    test('rejects an address without @ or domain', () {
      expect(CredentialValidator.email('carlos.restrepo'), CredentialFailure.invalidEmail);
      expect(CredentialValidator.email('carlos@correo'), CredentialFailure.invalidEmail);
    });
  });

  group('password', () {
    test('only has to be present to sign in', () {
      expect(CredentialValidator.password('x'), isNull);
      expect(CredentialValidator.password(''), CredentialFailure.emptyPassword);
    });

    test('needs at least 8 characters when it is new', () {
      expect(CredentialValidator.newPassword(''), CredentialFailure.emptyPassword);
      expect(CredentialValidator.newPassword('1234567'), CredentialFailure.shortPassword);
      expect(CredentialValidator.newPassword('12345678'), isNull);
    });
  });
}
