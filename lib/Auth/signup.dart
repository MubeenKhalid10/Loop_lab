import 'package:flutter/material.dart';
import 'package:loop_lab/Widgets/input_field.dart';
import 'package:provider/provider.dart';
import 'package:loop_lab/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _username = TextEditingController();
  String _role = 'Student';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InputField(
                  controller: _username,
                  hintText: 'Username',
                  prefixIcon: Icons.person),
              SizedBox(height: 12),
              InputField(
                  controller: _email,
                  hintText: 'Email',
                  prefixIcon: Icons.email),
              SizedBox(height: 12),
              InputField(
                controller: _password,
                hintText: 'Password',
                prefixIcon: Icons.password,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _role,
                items: const [
                  DropdownMenuItem(value: 'Student', child: Text('Student')),
                  DropdownMenuItem(value: 'Teacher', child: Text('Teacher')),
                ],
                onChanged: (v) => setState(() => _role = v!),
                decoration: const InputDecoration(labelText: 'Register as'),
              ),
              SizedBox(height: 20),
              _loading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() => _loading = true);
                        try {
                          await auth.registerWithEmail(
                              _email.text.trim(),
                              _password.text.trim(),
                              _username.text.trim(),
                              _role);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Registered successfully')));
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: \$e')));
                        } finally {
                          setState(() => _loading = false);
                        }
                      },
                      child: const Text('Sign Up'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
