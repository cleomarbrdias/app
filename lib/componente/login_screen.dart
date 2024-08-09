import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:conass/bloc/auth_provider.dart';
import 'package:conass/util/cores.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: GestureDetector(
        onTap: () {
          // Esconder o teclado ao tocar fora das TextFields
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Cores.AnalogasVerdeClaro, Cores.AnalogasVerdeEscuro],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 40),
                    Center(
                      child: Image.asset(
                        "images/estrela.png",
                        height: 100,
                      ),
                    ),
                    SizedBox(height: 40),
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Usuário',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Cores.LaranjaEscuro, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Cores.LaranjaEscuro, width: 2.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Cores.LaranjaEscuro),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Cores.LaranjaEscuro, width: 2.0),
                        ),
                      ),
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 20),
                    _isLoading
                        ? Center(child: CircularProgressIndicator())
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              await authProvider.login(
                                _usernameController.text,
                                _passwordController.text,
                              );
                              setState(() {
                                _isLoading = false;
                              });
                              if (authProvider.user != null) {
                                Navigator.pop(
                                    context); // Voltar à tela anterior após o login bem-sucedido
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Cores.LaranjaClaro,
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              textStyle: TextStyle(fontSize: 18),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// import 'package:conass/bloc/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       //appBar: AppBar(title: Text('Login')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             await authProvider.login();
//             if (authProvider.user != null) {
//               Navigator.pop(
//                   context); // Voltar à tela anterior após o login bem-sucedido
//             }
//           },
//           child: Text('Login with Keycloak'),
//         ),
//       ),
//     );
//   }
// }
