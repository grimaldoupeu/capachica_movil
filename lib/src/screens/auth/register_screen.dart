import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Would be used for BLoC
// import '../../blocs/auth_bloc/auth_bloc.dart'; // Import AuthBloc and events
// import '../../models/usuario/user_model.dart'; // Import UserRole

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // UserRole _selectedRole = UserRole.turista; // Default role

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitRegister() {
    if (_formKey.currentState!.validate()) {
      // In a real app with BLoC:
      // BlocProvider.of<AuthBloc>(context).add(
      //   RegisterRequested(
      //     nombre: _nameController.text,
      //     email: _emailController.text,
      //     password: _passwordController.text,
      //     // rol: _selectedRole, // Pass the selected role
      //   ),
      // );
      print('Register attempt: Name: ${_nameController.text}, Email: ${_emailController.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Register attempt for ${_emailController.text}. Check console.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView( // Changed to ListView to prevent overflow with more fields/options
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
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
                  if (value == null || value.isEmpty || value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              // Placeholder for Role selection if needed - for now, defaults to turista in BLoC event
              // const SizedBox(height: 16),
              // DropdownButtonFormField<UserRole>(
              //   value: _selectedRole,
              //   decoration: const InputDecoration(labelText: 'Role'),
              //   items: UserRole.values.map((UserRole role) {
              //     return DropdownMenuItem<UserRole>(
              //       value: role,
              //       child: Text(role.toString().split('.').last),
              //     );
              //   }).toList(),
              //   onChanged: (UserRole? newValue) {
              //     setState(() {
              //       _selectedRole = newValue!;
              //     });
              //   },
              // ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitRegister,
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  // In a real app, navigate to LoginScreen
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
                  print('Navigate to Login Screen (Placeholder)');
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Navigate to Login Screen (Placeholder)')),
                  );
                },
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
