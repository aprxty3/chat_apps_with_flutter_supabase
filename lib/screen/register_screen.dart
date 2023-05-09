import 'package:chat_apps_with_flutter_supabase/screen/chat_screen.dart';
import 'package:chat_apps_with_flutter_supabase/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/constans.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.isRegistering});

  static Route<void> route({bool isRegistering = false}) {
    return MaterialPageRoute(
      builder: (context) => RegisterScreen(isRegistering: isRegistering),
    );
  }

  final bool isRegistering;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  Future<void> _signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;
    try {
      await supabase.auth.signUp(
          email: email, password: password, data: {'username': username});
      Navigator.pushAndRemoveUntil(
          context, ChatScreen.route(), (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: formPadding,
          children: [
            _emailForm(),
            formSpacer,
            _passwordForm(),
            formSpacer,
            _usernameForm(),
            formSpacer,
            _registerButton(),
            formSpacer,
            _loginButton(),
          ],
        ),
      ),
    );
  }

  _emailForm() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        label: Text('Email'),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Dibutuhkan';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
    );
  }

  _passwordForm() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        label: Text('Password'),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Dibutuhkan';
        }
        if (val.length < 6) {
          return 'minimum 6 karakter';
        }
        return null;
      },
    );
  }

  _usernameForm() {
    return TextFormField(
      controller: _usernameController,
      decoration: const InputDecoration(
        label: Text('Username'),
      ),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Dibutuhkan';
        }
        final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
        if (!isValid) {
          return '3-24 dengan alphanumeric atau underscore';
        }
        return null;
      },
    );
  }

  _registerButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _signUp,
      child: const Text('Register'),
    );
  }

  _loginButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(context, LoginScreen.route());
      },
      child: const Text('Sudah Punya Akun? Login'),
    );
  }
}
