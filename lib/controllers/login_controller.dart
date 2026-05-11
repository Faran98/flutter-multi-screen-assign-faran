class RegisterController {

  bool isFormValid({
    required bool firstName,
    required bool lastName,
    required bool email,
    required bool password,
    required bool confirmPassword,
  }) {
    return firstName &&
        lastName &&
        email &&
        password &&
        confirmPassword;
  }
}