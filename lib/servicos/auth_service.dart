import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  final String keycloakUrl = 'https://keycloack-homol.conass.org.br';
  final String clientId = 'appConass';
  final String clientSecret = 'QMGVWGaifTctfSO2gbawFZKDZrqfch4b';

  Future<void> login(String username, String password) async {
    final tokenUrl = '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token';
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': 'password',
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      await secureStorage.write(
          key: 'access_token', value: responseData['access_token']);
      await secureStorage.write(
          key: 'refresh_token', value: responseData['refresh_token']);
      print('Login successful');
      print('Access token: ${responseData['access_token']}');
    } else {
      print(
          'Erro ao receber token. Status code: ${response.statusCode}, Response: ${response.body}');
    }
  }

  Future<String?> tokenClient() async {
    final tokenUrl = '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token';
    final response = await http.post(
      Uri.parse(tokenUrl),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'grant_type': 'client_credentials',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['access_token'];
    } else {
      print(
          'Erro ao receber token client. Status code: ${response.statusCode}, Response: ${response.body}');
      return null;
    }
  }

  Future<void> logout() async {
    await secureStorage.deleteAll();
  }

  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: 'access_token');
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    final accessToken = await secureStorage.read(key: 'access_token');
    if (accessToken == null) return null;

    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      return decodedToken;
    } catch (e) {
      print('Failed to decode token: $e');
      return null;
    }
  }

  Future<List<String>> getUserGroups(String userId) async {
    final clientAccessToken = await tokenClient();
    if (clientAccessToken == null) {
      print('Erro ao obter token do cliente.');
      return [];
    }

    final groupUrl = '$keycloakUrl/admin/realms/CIEGES/users/$userId/groups';
    final response = await http.get(
      Uri.parse(groupUrl),
      headers: {
        'Authorization': 'Bearer $clientAccessToken',
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body) as List<dynamic>;
      return responseData.map((group) => group['name'].toString()).toList();
    } else {
      print(
          'Erro ao buscar grupo. Status code: ${response.statusCode}, Response: ${response.body}');
      return [];
    }
  }

  Future<bool> checkAuthenticated() async {
    final accessToken = await getAccessToken();
    if (accessToken == null) return false;

    final response = await http.post(
      Uri.parse(
          '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token/introspect'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
      },
      body: {
        'token': accessToken,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return responseData['active'] == true;
    } else {
      return false;
    }
  }
}

// class AuthService {
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();
//   final String keycloakUrl = 'https://keycloack-homol.conass.org.br';
//   final String clientId = 'appConass';
//   final String clientSecret = 'QMGVWGaifTctfSO2gbawFZKDZrqfch4b';

//   Future<void> login(String username, String password) async {
//     final tokenUrl = '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token';
//     final response = await http.post(
//       Uri.parse(tokenUrl),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'client_id': clientId,
//         'client_secret': clientSecret,
//         'grant_type': 'password',
//         'username': username,
//         'password': password,
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       await secureStorage.write(
//           key: 'access_token', value: responseData['access_token']);
//       await secureStorage.write(
//           key: 'refresh_token', value: responseData['refresh_token']);
//       print('Login successful');
//       print('Access token: ${responseData['access_token']}');
//     } else {
//       print(
//           'Erro ao receber token. Status code: ${response.statusCode}, Response: ${response.body}');
//     }
//   }

//   Future<void> tokenClient() async {
//     final tokenUrl = '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token';
//     final response = await http.post(
//       Uri.parse(tokenUrl),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'client_id': clientId,
//         'client_secret': clientSecret,
//         'grant_type': 'client_credentials',
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       await secureStorage.write(
//           key: 'access_token', value: responseData['access_token']);
//       await secureStorage.write(
//           key: 'refresh_token', value: responseData['refresh_token']);
//       print('Login successful');
//       print('Access token: ${responseData['access_token']}');
//     } else {
//       print(
//           'Erro ao receber token. Status code: ${response.statusCode}, Response: ${response.body}');
//     }
//   }

//   Future<void> logout() async {
//     await secureStorage.deleteAll();
//   }

//   Future<String?> getAccessToken() async {
//     return await secureStorage.read(key: 'access_token');
//   }

//   Future<Map<String, dynamic>?> getUserInfo() async {
//     final accessToken = await secureStorage.read(key: 'access_token');
//     if (accessToken == null) return null;

//     try {
//       Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
//       return decodedToken;
//     } catch (e) {
//       print('Failed to decode token: $e');
//       return null;
//     }
//   }

//   Future<List<String>> getUserGroups(String userId, String accessToken) async {
//     print(userId);
//     final groupUrl = '$keycloakUrl/admin/realms/CIEGES/users/$userId/groups';
//     print(groupUrl);
//     final response = await http.get(
//       Uri.parse(groupUrl),
//       headers: {
//         'Authorization': '''Bearer''' '''$accessToken''',
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body) as List<dynamic>;

//       return responseData.map((group) => group['name'].toString()).toList();
//     } else {
//       print(
//           'Error ao buscar grupo. Status code: ${response.statusCode}, Response: ${response.body}');
//       return [];
//     }
//   }

//   Future<bool> checkAuthenticated() async {
//     final accessToken = await getAccessToken();
//     if (accessToken == null) return false;

//     final response = await http.post(
//       Uri.parse(
//           '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token/introspect'),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization':
//             'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
//       },
//       body: {
//         'token': accessToken,
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       return responseData['active'] == true;
//     } else {
//       return false;
//     }
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:jwt_decoder/jwt_decoder.dart'; // Adicione esta dependência

// class AuthService {
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();
//   final String keycloakUrl = 'https://keycloack-homol.conass.org.br';
//   final String clientId = 'appConass';
//   final String clientSecret = 'QMGVWGaifTctfSO2gbawFZKDZrqfch4b';

//   Future<void> login(String username, String password) async {
//     final tokenUrl = '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token';
//     final response = await http.post(
//       Uri.parse(tokenUrl),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: {
//         'client_id': clientId,
//         'client_secret': clientSecret,
//         'grant_type': 'password',
//         'username': username,
//         'password': password,
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       await secureStorage.write(
//           key: 'access_token', value: responseData['access_token']);
//       await secureStorage.write(
//           key: 'refresh_token', value: responseData['refresh_token']);
//       print('Login successful');
//       print('Access token: ${responseData['access_token']}');
//     } else {
//       print(
//           'Failed to retrieve tokens. Status code: ${response.statusCode}, Response: ${response.body}');
//     }
//   }

//   Future<void> logout() async {
//     await secureStorage.deleteAll();
//   }

//   Future<String?> getAccessToken() async {
//     return await secureStorage.read(key: 'access_token');
//   }

//   Future<Map<String, dynamic>?> getUserInfo() async {
//     final accessToken = await secureStorage.read(key: 'access_token');
//     if (accessToken == null) return null;

//     try {
//       Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
//       return decodedToken;
//     } catch (e) {
//       print('Failed to decode token: $e');
//       return null;
//     }
//   }

//   Future<bool> checkAuthenticated() async {
//     final accessToken = await getAccessToken();
//     if (accessToken == null) return false;

//     final response = await http.post(
//       Uri.parse(
//           '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token/introspect'),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization':
//             'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
//       },
//       body: {
//         'token': accessToken,
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       return responseData['active'] == true;
//     } else {
//       return false;
//     }
//   }
// }



// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:uni_links/uni_links.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:conass/modelo/user.dart';
// import 'package:flutter/material.dart';

// class AuthService {
//   final FlutterSecureStorage secureStorage = FlutterSecureStorage();
//   final String keycloakUrl = 'https://keycloack-homol.conass.org.br';
//   final String clientId = 'appConass';
//   final String clientSecret = 'QMGVWGaifTctfSO2gbawFZKDZrqfch4b';
//   final String redirectUri = 'myapp://auth';

//   StreamSubscription? _sub;
//   BuildContext? context;

//   AuthService({this.context}) {
//     initUniLinks();
//   }

//   Future<void> initUniLinks() async {
//     _sub = uriLinkStream.listen((Uri? uri) {
//       if (uri != null && uri.toString().startsWith(redirectUri)) {
//         print('Received URI: $uri');
//         handleAuthResponse(uri);
//       }
//     }, onError: (Object err) {
//       print('Failed to handle uni link: $err');
//     });
//   }

//   Future<void> login() async {
//     final authUrl = '$keycloakUrl/realms/CIEGES/protocol/openid-connect/auth'
//         '?client_id=$clientId&response_type=code&scope=openid&redirect_uri=$redirectUri';

//     print('Launching URL: $authUrl');

//     if (await canLaunch(authUrl)) {
//       await launch(authUrl);
//     } else {
//       throw 'Could not launch $authUrl';
//     }
//   }

//   Future<void> handleAuthResponse(Uri uri) async {
//     final code = uri.queryParameters['code'];
//     if (code != null) {
//       print('Authorization code: $code');
//       final tokenUrl =
//           '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token';
//       final response = await http.post(
//         Uri.parse(tokenUrl),
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: {
//           'client_id': clientId,
//           'client_secret': clientSecret,
//           'grant_type': 'authorization_code',
//           'code': code,
//           'redirect_uri': redirectUri,
//         },
//       );

//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         await secureStorage.write(
//             key: 'access_token', value: responseData['access_token']);
//         await secureStorage.write(
//             key: 'refresh_token', value: responseData['refresh_token']);
//         print('Login successful');
//         print('Access token: ${responseData['access_token']}');
//         await getUserInfo();

//         // Fechar o navegador após login bem-sucedido
//         if (context != null) {
//           Navigator.of(context!).pop();
//         }
//       } else {
//         print(
//             'Failed to retrieve tokens. Status code: ${response.statusCode}, Response: ${response.body}');
//       }
//     }
//   }

//   Future<void> logout() async {
//     await secureStorage.deleteAll();
//   }

//   Future<String?> getAccessToken() async {
//     return await secureStorage.read(key: 'access_token');
//   }

//   Future<User?> getUserInfo() async {
//     final accessToken = await secureStorage.read(key: 'access_token');
//     if (accessToken == null) return null;

//     final response = await http.get(
//       Uri.parse('$keycloakUrl/realms/CIEGES/protocol/openid-connect/userinfo'),
//       headers: {
//         'Authorization': 'Bearer $accessToken',
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       print('User info: $responseData');
//       return User(
//         username: responseData['preferred_username'],
//         firstName: responseData['given_name'],
//         lastName: responseData['family_name'],
//         groups:
//             (responseData['groups'] as List<dynamic>?)?.cast<String>() ?? [],
//         accessToken: accessToken,
//       );
//     } else {
//       print(
//           'Failed to retrieve user info. Status code: ${response.statusCode}, Response: ${response.body}');
//       return null;
//     }
//   }

//   Future<bool> checkAuthenticated() async {
//     final accessToken = await getAccessToken();
//     if (accessToken == null) return false;

//     final response = await http.post(
//       Uri.parse(
//           '$keycloakUrl/realms/CIEGES/protocol/openid-connect/token/introspect'),
//       headers: {
//         'Content-Type': 'application/x-www-form-urlencoded',
//         'Authorization':
//             'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
//       },
//       body: {
//         'token': accessToken,
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       return responseData['active'] == true;
//     } else {
//       return false;
//     }
//   }
// }
