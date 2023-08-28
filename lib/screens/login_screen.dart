import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deber de Aplicaciones móviles'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'MiApp',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Usuario'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Clave'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                final loginProvider =
                    Provider.of<LoginProvider>(context, listen: false);
                await loginProvider
                    .signIn(
                  _emailController.text,
                  _passwordController.text,
                )
                    .catchError(
                  (error) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Error'),
                        content: Text(
                            'No se pudo iniciar sesión. Inténtelo de nuevo.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                );
                if (loginProvider.user != null) {
                  Navigator.pushReplacementNamed(context, MainWidget.routeName);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.fromLTRB(60, 20, 60, 20), // Ajusta el tamaño vertical
              ),
              child: Text('Iniciar Sesión', style: TextStyle(fontSize: 18),),
            ),
          ],
        ),
      ),
    );
  }
}
