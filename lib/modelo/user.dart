class User {
  final String username;
  String? userID;
  final String firstName;
  final String lastName;
  final List<String> groups;
  final List<String> roles;
  final String accessToken;

  User({
    required this.username,
    this.userID,
    required this.firstName,
    required this.lastName,
    required this.groups,
    required this.roles,
    required this.accessToken,
  });

  factory User.fromJson(Map<String, dynamic> json, String accessToken) {
    return User(
      username: json['preferred_username'],
      firstName: json['given_name'],
      lastName: json['family_name'],
      groups: json['groups'] != null
          ? List<String>.from(json['groups'].map((g) => g['name']))
          : [],
      roles: List<String>.from(json['realm_access']['roles'] ?? []),
      accessToken: accessToken,
    );
  }
}



// class User {
//   final String username;
//   final String firstName;
//   final String lastName;
//   final List<String> groups;
//   final String accessToken;

//   User({
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     required this.groups,
//     required this.accessToken,
//   });

//   factory User.fromJson(Map<String, dynamic> json, String accessToken) {
//     return User(
//       username: json['preferred_username'],
//       firstName: json['given_name'],
//       lastName: json['family_name'],
//       groups: List<String>.from(json['realm_access']['roles'] ?? []),
//       accessToken: accessToken,
//     );
//   }
// }


// class User {
//   final String username;
//   final String firstName;
//   final String lastName;
//   final List<String> groups;
//   final String accessToken;

//   User({
//     required this.username,
//     required this.firstName,
//     required this.lastName,
//     required this.groups,
//     required this.accessToken,
//   });

//   factory User.fromJson(Map<String, dynamic> json, String accessToken) {
//     return User(
//       username: json['preferred_username'],
//       firstName: json['given_name'],
//       lastName: json['family_name'],
//       groups: List<String>.from(json['groups'] ?? []),
//       accessToken: accessToken,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'preferred_username': username,
//       'given_name': firstName,
//       'family_name': lastName,
//       'groups': groups,
//       'access_token': accessToken,
//     };
//   }
// }
