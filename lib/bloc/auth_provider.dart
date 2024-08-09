import 'package:conass/modelo/user.dart';
import 'package:conass/servicos/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  String? _accessToken;

  User? get user => _user;
  String? get accessToken => _accessToken;

  Future<void> login(String username, String password) async {
    try {
      await _authService.login(username, password);
      _accessToken = await _authService.getAccessToken();
      final userInfo = await _authService.getUserInfo();
      if (userInfo != null && _accessToken != null) {
        _user = User.fromJson(userInfo, _accessToken!);
        final groups = await _authService.getUserGroups(userInfo['sub']);
        _user!.groups.addAll(groups); // Adiciona os grupos obtidos ao usuário
      }
      notifyListeners();
    } catch (e) {
      print('Failed to login: $e');
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      _user = null;
      _accessToken = null;
      notifyListeners();
    } catch (e) {
      print('Failed to logout: $e');
    }
  }

  Future<void> checkUser() async {
    try {
      if (await _authService.checkAuthenticated()) {
        _accessToken = await _authService.getAccessToken();
        final userInfo = await _authService.getUserInfo();
        if (userInfo != null && _accessToken != null) {
          _user = User.fromJson(userInfo, _accessToken!);
          final groups = await _authService.getUserGroups(userInfo['sub']);
          _user!.groups.addAll(groups); // Adiciona os grupos obtidos ao usuário
        }
      } else {
        _user = null;
        _accessToken = null;
      }
      notifyListeners();
    } catch (e) {
      print('Failed to check user: $e');
    }
  }
}

// class AuthProvider with ChangeNotifier {
//   final AuthService _authService = AuthService();
//   User? _user;
//   String? _accessToken;

//   User? get user => _user;
//   String? get accessToken => _accessToken;

//   Future<void> login(String username, String password) async {
//     try {
//       await _authService.login(username, password);
//       _accessToken = await _authService.getAccessToken();
//       final userInfo = await _authService.getUserInfo();
//       if (userInfo != null && _accessToken != null) {
//         _user = User.fromJson(userInfo, _accessToken!);
//         final groups =
//             await _authService.getUserGroups(userInfo['sub'], _accessToken!);
//         _user!.groups.addAll(groups); // Adiciona os grupos obtidos ao usuário
//       }
//       notifyListeners();
//     } catch (e) {
//       print('Failed to login: $e');
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await _authService.logout();
//       _user = null;
//       _accessToken = null;
//       notifyListeners();
//     } catch (e) {
//       print('Failed to logout: $e');
//     }
//   }

//   Future<void> checkUser() async {
//     try {
//       if (await _authService.checkAuthenticated()) {
//         _accessToken = await _authService.getAccessToken();
//         final userInfo = await _authService.getUserInfo();
//         if (userInfo != null && _accessToken != null) {
//           _user = User.fromJson(userInfo, _accessToken!);
//           final groups =
//               await _authService.getUserGroups(userInfo['sub'], _accessToken!);
//           _user!.groups.addAll(groups); // Adiciona os grupos obtidos ao usuário
//         }
//       } else {
//         _user = null;
//         _accessToken = null;
//       }
//       notifyListeners();
//     } catch (e) {
//       print('Failed to check user: $e');
//     }
//   }
// }


// import 'package:conass/modelo/user.dart';
// import 'package:conass/servicos/auth_service.dart';
// import 'package:flutter/material.dart';

// class AuthProvider with ChangeNotifier {
//   final AuthService _authService = AuthService();
//   User? _user;
//   String? _accessToken;

//   User? get user => _user;
//   String? get accessToken => _accessToken;

//   Future<void> login(String username, String password) async {
//     try {
//       await _authService.login(username, password);
//       _accessToken = await _authService.getAccessToken();
//       final userInfo = await _authService.getUserInfo();
//       if (userInfo != null && _accessToken != null) {
//         _user = User.fromJson(userInfo, _accessToken!);
//       }
//       notifyListeners();
//     } catch (e) {
//       print('Failed to login: $e');
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await _authService.logout();
//       _user = null;
//       _accessToken = null;
//       notifyListeners();
//     } catch (e) {
//       print('Failed to logout: $e');
//     }
//   }

//   Future<void> checkUser() async {
//     try {
//       if (await _authService.checkAuthenticated()) {
//         _accessToken = await _authService.getAccessToken();
//         final userInfo = await _authService.getUserInfo();
//         if (userInfo != null && _accessToken != null) {
//           _user = User.fromJson(userInfo, _accessToken!);
//         }
//       } else {
//         _user = null;
//         _accessToken = null;
//       }
//       notifyListeners();
//     } catch (e) {
//       print('Failed to check user: $e');
//     }
//   }
// }


// import 'package:conass/modelo/user.dart';
// import 'package:conass/servicos/auth_service.dart';
// import 'package:flutter/material.dart';

// class AuthProvider with ChangeNotifier {
//   final AuthService _authService = AuthService();
//   User? _user;

//   User? get user => _user;

//   Future<void> login() async {
//     try {
//       await _authService.login();
//       final accessToken = await _authService.getAccessToken();
//       final userInfo = await _authService.getUserInfo();
//       if (userInfo != null && accessToken != null) {
//         _user = User.fromJson(userInfo.toJson(), accessToken);
//       }
//       notifyListeners();
//     } catch (e) {
//       print('Failed to login: $e');
//     }
//   }

//   Future<void> logout() async {
//     try {
//       await _authService.logout();
//       _user = null;
//       notifyListeners();
//     } catch (e) {
//       print('Failed to logout: $e');
//     }
//   }

//   Future<void> checkUser() async {
//     try {
//       if (await _authService.checkAuthenticated()) {
//         final accessToken = await _authService.getAccessToken();
//         final userInfo = await _authService.getUserInfo();
//         if (userInfo != null && accessToken != null) {
//           _user = User.fromJson(userInfo.toJson(), accessToken);
//         }
//       } else {
//         _user = null;
//       }
//       notifyListeners();
//     } catch (e) {
//       print('Failed to check user: $e');
//     }
//   }
// }
