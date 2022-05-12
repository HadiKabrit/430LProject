class User {
  final String username;
  final String password;

  const User({
    required this.username,
    required this.password,
  });
}

class UserForSignUp {
  final String username;
  final String password;
  final String phone;

  const UserForSignUp({
    required this.username,
    required this.password,
    required this.phone,
  });
}
