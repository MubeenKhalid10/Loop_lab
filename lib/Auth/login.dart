import 'package:flutter/material.dart';
import 'package:loop_lab/Widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:loop_lab/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InputField(
                  controller: _email,
                  hintText: 'Email',
                  prefixIcon: Icons.email),
              SizedBox(height: 12),
              InputField(
                  controller: _password,
                  hintText: 'Password',
                  prefixIcon: Icons.password,
                  isPassword: true),
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() => _loading = true);
                        try {
                          await auth.signInWithEmail(
                              _email.text.trim(), _password.text.trim());
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Logged in')));
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: \$e')));
                        } finally {
                          setState(() => _loading = false);
                        }
                      },
                      child: const Text('Login'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
