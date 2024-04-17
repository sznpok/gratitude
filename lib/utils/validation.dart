class ValidationMixin {
  validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value.trim())) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Mobile Number Required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Invalid Mobile Number";
    } else if (value.trim().length != 10) {
      return "Mobile Number must be 10 digit";
    } else if (!value.trim().startsWith('98') &&
        !value.trim().startsWith('97') &&
        !value.trim().startsWith('96')) {
      return "Mobile Number must be started with 98 or 97 or 96";
    }
    return null;
  }

  validatePin(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "Pin code required";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Invalid Pin Number";
    } else if (value.length < 5) {
      return "Pin number must be 5 digit";
    }
    return null;
  }

  validateName(String value, {String? title}) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return title == null ? "required*" : "$title is required ";
    } else if (!regExp.hasMatch(value.trim())) {
      return "Error*";
    }
    return null;
  }

  validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is Required";
    } else if (value.length < 7) {
      return "Password must be 8 digit";
    }
    return null;
  }

  validateNumber(String value) {
    if (value.isEmpty) {
      return "required*";
    }
    return null;
  }
}
