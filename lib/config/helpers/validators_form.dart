class PasswordErrors {
  static const String isEmpty = 'Debe ingresar una contraseña';
  static const String isLeastLength =
      'La contraseña debe ser mayor a 8 caracteres';
  static const String isSpecialCaracters =
      'La contraseña debe contener al menos un caracter especial.';

  PasswordErrors();
}

class RutErrors {
  static const String isEmpty = 'Debe ingresar el rut.';
  static const String isInvalidRut = 'El rut es invalido.';
  static const String isIncorrectStructure =
      'La estructura del rut es invalida.';

  RutErrors();
}

class ValidatorsForm {
  static bool isValidEmail(value) {
    return RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@(usm|sansano)\.cl$")
        .hasMatch(value);
  }

  static bool isValidRut(value) {
    return RegExp(r'^(\d{1,3}(?:.\d{1,3}){2}-[\dkK])$').hasMatch(value);
  }

  static bool isPasswordDefined(String value) {
    return value.isEmpty;
  }

  static List<String> isCorrectFormatPassword(String value) {
    final errors = [
      PasswordErrors.isEmpty,
      PasswordErrors.isLeastLength,
      PasswordErrors.isSpecialCaracters,
    ];

    if (value.isNotEmpty) {
      errors.remove(PasswordErrors.isEmpty);
    }
    if (value.length >= 8) {
      errors.remove(PasswordErrors.isLeastLength);
    }
    RegExp regexCaractSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (regexCaractSpecial.hasMatch(value)) {
      errors.remove(PasswordErrors.isSpecialCaracters);
    }
    return errors;
  }

  static List<String> isCorrectRut(String input) {
    final errors = [
      RutErrors.isEmpty,
      RutErrors.isIncorrectStructure,
      RutErrors.isInvalidRut,
    ];
    bool rutValidator(String rut) {
      int rutBody;
      String dv;
      int M = 0;
      int S = 1;
      if (rut.contains('-')) {
        var splitRut = rut.split('-');
        rutBody = int.parse(splitRut[0].replaceAll('.', ''));
        dv = splitRut[1];
      } else {
        rutBody = int.parse(rut.substring(0, rut.length - 1));
        dv = rut.substring(rut.length - 1);
      }
      for (; rutBody != 0; rutBody ~/= 10) {
        S = (S + rutBody % 10 * (9 - M++ % 6)) % 11;
      }
      String checkChar = (S > 0) ? '${S - 1}' : 'k';
      return dv.toLowerCase() == checkChar;
    }

    RegExp rut = RegExp(r'^(\d{1,3}(?:.\d{1,3}){2}-[\dkK])$');

    if (rutValidator(input)) {
      errors.remove(RutErrors.isInvalidRut);
    }
    if (rut.hasMatch(input)) {
      errors.remove(RutErrors.isIncorrectStructure);
    }
    if (input.isNotEmpty) {
      errors.remove(RutErrors.isEmpty);
    }

    return errors;
  }
}
