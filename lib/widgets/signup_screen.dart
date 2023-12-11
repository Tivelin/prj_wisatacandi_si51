// ignore_for_file: unused_field, unused_local_variable, non_constant_identifier_names, unused_element, avoid_print, annotate_overrides

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // TODO: 1. Deklarasi Variabel
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Logger _logger = Logger();

  //SignUpScreen({super.key});

  String _errorText = '';
  final bool _isSignedUp = false;
  bool _obscurePassword = true;

  // TODO : 1. membuat metode _signUp

  void _signUp() {
    String fullname = _fullnameController.text.trim();
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        _errorText =
            'Password minimal 8 karakter, kombinasi [A-Z],[a-z],[0-9], [@#%^&*(),.?":{}|<>]';
      });
      return;
    }
    print('**Sign Up Berhasil**');
    print('Nama : $fullname');
    print('Nama Pengguna : $username');
    print('Password : $password');
  }

  // TODO : 2. membuat metode dispose
  void dispose() {
    // TODO : implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 2. Pasang Appbar
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      // TODO: 3. Pasang Body
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                // TODO : 4. Atur mainAxisAlignment dan CrossAxisAlignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // TODO: 5. Pasang TextFormField Nama Lengkap
                  TextFormField(
                    controller: _fullnameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Lengkap",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TODO: 6. Pasang TextFormField Nama Pengguna
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: "Nama Pengguna",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TODO: 7. Pasang textformfield Kata Sandi
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
                  const SizedBox(
                    height: 20,
                  ),
                  // TODO : 8. Pasang ElevatedButton Sign Up
                  ElevatedButton(
                    onPressed: () {
                      _performSignUp(context);
                      //_signUp();
                    },
                    child: const Text('Sign Up'),
                  ),
                  //TODO : 9. Pasang TextButton Sign In
                  const SizedBox(height: 18),
                  RichText(
                    text: TextSpan(
                      text: 'Sudah punya akun?',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Sign In disini.',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
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
  void _performSignUp(BuildContext context) {
    try{
      final prefs = SharedPreferences.getInstance();
      _logger.d('Sign up attempt');
      final String fullname = _fullnameController.text;
      final String username = _usernameController.text;
      final String password = _passwordController.text;

      if(username.isNotEmpty && password.isNotEmpty){
        final encrypt.Key key = encrypt.Key.fromLength(32);
        final iv = encrypt.IV.fromLength(16);
        final encrypter = encrypt.Encrypter(encrypt.AES(key));
        final encryptedUsername = encrypter.encrypt(username, iv: iv);
        final encryptedPassword = encrypter.encrypt(password, iv: iv);

        _saveEncryptedDataToPrefs(
          prefs,
          encryptedUsername.base64,
          encryptedPassword.base64,
          key.base64,
          iv.base64,
        ).then((_) {
          Navigator.pop(context);
          _logger.d('Sign up succeeded');
        });
      }else{
        _logger.e('Username or password cannot be empty');
      }
    } catch (e){
      _logger.e('An Error Occured: $e');
    }
  }
Future<void> _saveEncryptedDataToPrefs(
    Future<SharedPreferences> prefs,
    String encryptedUsername,
    String encryptedPassword,
    String keyString,
    String ivString,
    ) async {
  final sharedPreferences = await prefs;
  // Logging: menyimpan data pengguna ke SharedPreferences
  _logger.d('Saving user data to SharedPreferences');
  await sharedPreferences.setString('username', encryptedUsername);
  await sharedPreferences.setString('password', encryptedPassword);
  await sharedPreferences.setString('key', keyString);
  await sharedPreferences.setString('iv', ivString);
  }  
}