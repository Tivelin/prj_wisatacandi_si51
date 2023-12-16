// ignore_for_file: unused_field, unused_import

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prj_wisatacandi_si51/widgets/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // TODO: 1. Deklarasikan Variabel
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Logger _logger = Logger();

  String _errorText = '';
  bool _isSignedIn = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 2. Pasang Appbar
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      // TODO: 3. Pasang Body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                // TODO: 4. Atur mainAxisAlignment dan CrossAxisAlignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // TODO: 5. Pasang TextForeField Nama Pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // TODO: 6. Pasang TextForeField Kata Sandi
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "Kata Sandi",
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  // TODO: 7. Pasang ElevatedButton Sign In
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _performSignIn();
                    },
                    child: const Text('Sign In'),
                  ),
                  // TODO: 8. Pasang TextButton Sign In
                  const SizedBox(height: 18),
                  RichText(
                    text: TextSpan(
                      text: 'Belum punya akun?',
                      style: const TextStyle(
                          fontSize: 16, color: Colors.deepPurple),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Daftar di sini.',
                            style: const TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ],
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

  Future<void> _performSignIn() async {
    try {
      final Future<SharedPreferences> prefsFuture =
      SharedPreferences.getInstance();

      final String username = _usernameController.text;
      final String password = _passwordController.text;
      _logger.d('Sign in attempt');

      if (username.isNotEmpty && password.isNotEmpty) {
        final SharedPreferences prefs = await prefsFuture;
        final data = await _retrieveAndDecryptDataFromPrefs(prefs as Future<SharedPreferences>);
          if (data.isNotEmpty) {
            final decryptedUsername = data['username'];
            final decryptedPassword = data['password'];
            
            if (username == decryptedUsername &&
                password == decryptedPassword) {
                _errorText = '';
                _isSignedIn = true;
                prefs.setBool('isSignedIn', true);
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacementNamed(context, '/');
                });
              _logger.d('Sign in succeeded');
            } else {
              _logger.e('Username or password is incorrect');
            }
          } else {
            _logger.e('No stored credentials found');
          }
      } else {
        _logger.e('Username and password cannot be empty');
      }
    } catch (e) {
      _logger.e('An error occurred: $e');
    }
  }

  Future<Map<String, String>> _retrieveAndDecryptDataFromPrefs(
    Future<SharedPreferences> prefs,
  ) async {
    final sharedPreferences = await prefs;
    final encryptedUsername = sharedPreferences.getString('username') ?? '';
    final encryptedPassword = sharedPreferences.getString('password') ?? '';
    final keyString = sharedPreferences.getString('key') ?? '';
    final ivString = sharedPreferences.getString('iv') ?? '';

    final encrypt.Key key = encrypt.Key.fromBase64(keyString);
    final iv = encrypt.IV.fromBase64(ivString);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final decryptedUsername = encrypter.decrypt64(encryptedUsername, iv: iv);
    final decryptedPassword = encrypter.decrypt64(encryptedPassword, iv: iv);

    // Mengembalikan data terdekripsi
    return {'username': decryptedUsername, 'password': decryptedPassword};
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const Center(
        child: Text('Welcome!'),
      ),
    );
  }
}