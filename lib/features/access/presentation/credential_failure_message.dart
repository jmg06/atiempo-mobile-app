import 'package:atiempo_mobile_app/features/access/domain/validators/credential_validator.dart';

extension CredentialFailureMessage on CredentialFailure {
  String get message => switch (this) {
    CredentialFailure.emptyEmail => 'Escribe tu correo electrónico',
    CredentialFailure.invalidEmail => 'Revisa el correo, por ejemplo nombre@correo.com',
    CredentialFailure.emptyPassword => 'Escribe tu clave',
    CredentialFailure.shortPassword => 'Al menos ${CredentialValidator.minPasswordLength} caracteres',
  };
}
