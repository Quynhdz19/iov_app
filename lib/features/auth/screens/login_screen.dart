import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/local/app_localizations.dart'; // Import AppLocalizations
import '../viewmodels/auth_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 50),
              // Logo
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).translate('welcome_back'),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context).translate('login_account'),
                      style: const TextStyle(fontSize: 16, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              // Username Field
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('username'),
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password Field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context).translate('password'),
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              // Login Button
              authViewModel.isLoading
                  ? Center(
                child: Text(
                  AppLocalizations.of(context).translate('loading'),
                  style: const TextStyle(color: AppColors.primaryColor),
                ),
              )
                  : ElevatedButton(
                onPressed: () async {
                  final username = usernameController.text;
                  final password = passwordController.text;

                  print('abc');
                  final success = await authViewModel.login('technician_01', 'Hanoi@123');
                  print(success);
                  if (success) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context).translate('error'),
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.primaryColor
                ),
                child: Text(
                  AppLocalizations.of(context).translate('login'),
                  style: const TextStyle(fontSize: 18, color: AppColors.backgroundColor),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}