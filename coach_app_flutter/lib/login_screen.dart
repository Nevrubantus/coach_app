import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'core/app_colors.dart';
import 'main.dart';
import 'registration_screen.dart';
import 'user_cache.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAthlete = true;
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final contact = _contactController.text.trim();
    final password = _passwordController.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    if (contact.isEmpty || password.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Пожалуйста, заполните все поля')),
      );
      return;
    }

    try {
      final user = await client.user.login(contact, password);

      if (user == null) {
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Неверный логин или пароль')),
        );
        return;
      }

      if (user.isAthlete != isAthlete) {
        if (!mounted) return;
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              user.isAthlete
                  ? 'Этот аккаунт зарегистрирован как спортсмен'
                  : 'Этот аккаунт зарегистрирован как тренер',
            ),
          ),
        );
        return;
      }

      await saveUserSession(user);

      if (!mounted) return;
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const RoleGate()),
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Ошибка сервера: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'С возвращением!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Войдите в свой аккаунт, чтобы продолжить',
                style: TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: appFieldColor(context),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _roleButton(
                        'Спортсмен',
                        isAthlete,
                        () => setState(() => isAthlete = true),
                      ),
                    ),
                    Expanded(
                      child: _roleButton(
                        'Тренер',
                        !isAthlete,
                        () => setState(() => isAthlete = false),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              _buildTextField(
                'Email или номер телефона',
                Icons.email_outlined,
                _contactController,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Пароль',
                Icons.lock_outline,
                _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Войти',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Впервые у нас?',
                    style: TextStyle(color: AppColors.textGrey, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegistrationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Создать аккаунт',
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : AppColors.textGrey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint,
    IconData icon,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: appMutedTextColor(context)),
        filled: true,
        fillColor: appFieldColor(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: appBorderColor(context)),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
      ),
    );
  }
}
