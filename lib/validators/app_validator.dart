class AppValidator {

  static String? emptyValidator(String value, String fieldName) {
    if (value.trim().isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String? emailValidator(String value) {
    if (value.isEmpty) {
      return "Email is required";
    }

    RegExp regex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!regex.hasMatch(value)) {
      return "Invalid email";
    }

    return null;
  }

  static String? passwordValidator(String value) {
    if (value.length < 6) {
      return "Minimum 6 characters";
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return "Must contain uppercase letter";
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return "Must contain special character";
    }

    return null;
  }

  static String? confirmPassword(
      String password,
      String confirmPassword,
      ) {
    if (password != confirmPassword) {
      return "Passwords do not match";
    }
    return null;
  }
}