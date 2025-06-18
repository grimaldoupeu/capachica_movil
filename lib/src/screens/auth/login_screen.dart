import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Would be used to provide/consume AuthBloc
// import '../../blocs/auth_bloc/auth_bloc.dart'; // Import AuthBloc and events

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin() {
    if (_formKey.currentState!.validate()) {
      // In a real app with BLoC:
      // BlocProvider.of<AuthBloc>(context).add(
      //   LoginRequested(
      //     email: _emailController.text,
      //     password: _passwordController.text,
      //   ),
      // );
      print('Login attempt: Email: ${_emailController.text}, Password: ${_passwordController.text}');
      // Placeholder: Show a snackbar or navigate based on a mock response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login attempt with ${_emailController.text}. Check console.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitLogin,
                child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  // In a real app, navigate to RegisterScreen
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const RegisterScreen()));
                  print('Navigate to Register Screen (Placeholder)');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigate to Register Screen (Placeholder)')),
                  );
                },
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
