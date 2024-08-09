import 'package:conass/bloc/auth_provider.dart';
import 'package:conass/componente/login_screen.dart';
import 'package:conass/util/cores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.user == null) {
      return Scaffold(
        //appBar: AppBar(title: Text('User Profile')),
        body: LoginScreen(),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Peril de Usuário')),
      body: Container(
        width: double.infinity,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Login: ${authProvider.user!.username}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Nome: ${authProvider.user!.firstName}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Sobrenome: ${authProvider.user!.lastName}',
                      style: TextStyle(fontSize: 16)),
                  SizedBox(height: 8),
                  Text('Groups:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ...authProvider.user!.groups
                      .map((group) => Text('- $group'))
                      .toList(),
                  SizedBox(height: 16),
                  Text('Roles:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ...authProvider.user!.roles
                      .map((role) => Text('- $role'))
                      .toList(),
                  SizedBox(height: 24),
                  Text('Access Token:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  SelectableText(authProvider.user!.accessToken),
                  SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          authProvider.logout();
                        },
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Cores.LaranjaClaro,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:conass/bloc/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class UserProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     if (authProvider.user == null) {
//       return Scaffold(
//         appBar: AppBar(title: Text('User Profile')),
//         body: Center(child: Text('No user logged in')),
//       );
//     }

//     return Scaffold(
//       appBar: AppBar(title: Text('User Profile')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Username: ${authProvider.user!.username}'),
//               SizedBox(height: 10),
//               Text('First Name: ${authProvider.user!.firstName}'),
//               SizedBox(height: 10),
//               Text('Last Name: ${authProvider.user!.lastName}'),
//               SizedBox(height: 10),
//               Text('Groups: ${authProvider.user!.groups.join(', ')}'),
//               SizedBox(height: 10),
//               Text('Access Token:'),
//               SizedBox(height: 10),
//               SelectableText(
//                 authProvider.user!.accessToken,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.black87,
//                 ),
//               ),
//               SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     authProvider.logout();
//                   },
//                   child: Text('Logout'),
//                 ),
//               ),
//               SizedBox(height: 20), // Adiciona espaço extra no final da página
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
