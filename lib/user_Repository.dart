

class UserModal{
  final String email;
  final String password;
  UserModal({required this.email,required this.password});
  toJson(){
    return {
    "Email": email,
     "Password" : password
  };
  }
}
