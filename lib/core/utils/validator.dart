class Validator {
  Validator._();

  static String? validateEmail(String? value) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    if (value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }

    if (value != null && !emailRegex.hasMatch(value)) {
      return "Email inválido.";
    }

    return null;
  }

  static String? validateFullName(String? value) {
    final nameRegex = RegExp(
        r"^[A-ZÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ][a-záéíóúâêîôûãõäëïöüç]+( [a-z]{1,3})?( [A-ZÁÉÍÓÚÂÊÎÔÛÃÕÄËÏÖÜÇ][a-záéíóúâêîôûãõäëïöüç]+)+$");

    if (value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }

    if (value != null && !nameRegex.hasMatch(value)) {
      return "Nome inválido.";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    final passwordRegex =
        RegExp(r"^(?=.*[A-Z])(?=.*\d)[A-Za-z\d@#$%^&+=!]{8,}$");

    if (value != null && value.isEmpty) {
      return "Esse campo não pode ser vazio.";
    }

    if (value != null && !passwordRegex.hasMatch(value)) {
      return "A senha não atende aos critérios obrigatórios.";
    }

    return null;
  }

  static String? validateConfirmPassword(String? first, String? second) {
    if (first != second) {
      return 'As senhas informadas são diferentes.';
    }

    return null;
  }
}
