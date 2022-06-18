String? validateMobileNum(String? value) {
  Pattern pattern = r"^[0-9]{9,10}$";
  String a = value!;
  RegExp regex = RegExp(pattern.toString());
  if (value.startsWith('0')) {
    a = value.replaceFirst('0', '');
    print(a);
  }
  if (value.trim().isEmpty) {
    return 'Please enter Mobile Number';
  }
  if (value.length == 10 && !value.startsWith('0')) {
    return 'Please enter a valid Mobile Number';
  }
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid Mobile Number';
  } else {
    return null;
  }
}

String? validatePassword(String? newPassword) {
  // Pattern pattern = r"^[0-9]{9}$";
  // RegExp regex = RegExp(pattern.toString());
  if (newPassword!.trim().isEmpty) {
    return 'Please enter password';
  }
  // if (newPassword != confirmPassword) {
  //   return 'Passwords do not match';
  // }
  if (newPassword.length < 4) {
    return 'Password length < 4 character';
  } else {
    return null;
  }
}

String? validateName(String? value) {
  if (value!.trim().isEmpty) {
    return 'Please enter name';
  }
  if (value.length < 2) {
    return 'Password length < 2 character';
  } else {
    return null;
  }
}
