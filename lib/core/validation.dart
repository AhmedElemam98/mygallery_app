class Validation {
  String? emailValidation(String value) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);
    if (value.trim().isEmpty) {
      return ('Enter email!');
    } else if (!regExp.hasMatch(value.trim())) {
      return ('Enter valid email!');
    } else {
      return null;
    }
  }

  String? passwordValidation(value) {
    if (value.isEmpty || value.length < 6) {
      return ('password must be more 6 digit');
    } else {
      return null;
    }
  }
}
