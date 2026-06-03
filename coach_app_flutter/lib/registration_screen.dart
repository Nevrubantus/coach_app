import 'package:coach_app_client/coach_app_client.dart' as server;
import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'app_ui.dart';
import 'core/app_colors.dart';
import 'main.dart';
import 'user_cache.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isAthlete = true;
  bool _personalDataAccepted = false;
  bool _isRegistering = false;
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_isRegistering) return;

    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    if (name.isEmpty || contact.isEmpty || password.isEmpty) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Заполните все поля')),
      );
      return;
    }

    if (password != confirmPassword) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Пароли не совпадают')),
      );
      return;
    }

    if (!_personalDataAccepted) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Подтвердите согласие на обработку персональных данных',
          ),
        ),
      );
      return;
    }

    setState(() => _isRegistering = true);
    try {
      final newUser = server.User(
        name: name,
        contact: contact,
        password: password,
        isAthlete: isAthlete,
      );

      final registeredUser = await client.user.register(newUser);

      if (registeredUser == null) {
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Этот логин уже занят')),
        );
        return;
      }

      await saveUserSession(registeredUser);

      if (!mounted) return;
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const RoleGate()),
        (_) => false,
      );
    } catch (e) {
      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(content: Text('Ошибка соединения с сервером: $e')),
      );
    } finally {
      if (mounted) setState(() => _isRegistering = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Регистрация',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Создайте аккаунт, чтобы начать тренировки',
                style: TextStyle(fontSize: 16, color: AppColors.textGrey),
              ),
              const SizedBox(height: 24),
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
              const SizedBox(height: 24),
              _buildTextField('Имя', Icons.person_outline, _nameController),
              const SizedBox(height: 20),
              _buildTextField(
                'Email или номер телефона',
                Icons.alternate_email,
                _contactController,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Пароль',
                Icons.lock_outline,
                _passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Подтвердите пароль',
                Icons.lock_reset_outlined,
                _confirmPasswordController,
                isPassword: true,
              ),
              const SizedBox(height: 18),
              _personalDataConsentCard(),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _personalDataAccepted && !_isRegistering
                      ? _register
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    disabledBackgroundColor: isAppDark(context)
                        ? const Color(0xFF2A2D36)
                        : const Color(0xFFE6E8EF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _isRegistering
                        ? 'Создаём аккаунт...'
                        : 'Зарегистрироваться',
                    style: TextStyle(
                      color: _personalDataAccepted
                          ? Colors.white
                          : AppColors.textGrey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _personalDataConsentCard() {
    return Material(
      color: appFieldColor(context),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: () => setState(() {
          _personalDataAccepted = !_personalDataAccepted;
        }),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 14, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _personalDataAccepted
                  ? AppColors.primaryBlue
                  : const Color(0xFFE6E8EF),
              width: _personalDataAccepted ? 1.4 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 34,
                height: 34,
                child: Checkbox(
                  value: _personalDataAccepted,
                  activeColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: const BorderSide(color: Color(0xFFB8BBC5), width: 1.5),
                  onChanged: (value) => setState(() {
                    _personalDataAccepted = value ?? false;
                  }),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Согласие на обработку данных',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Я ознакомлен(а) с условиями обработки персональных данных и даю согласие на их обработку для работы приложения.',
                      style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 12.5,
                        height: 1.28,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: _showPersonalDataInfo,
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 32),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: AppColors.primaryBlue,
                        ),
                        child: const Text(
                          'Подробнее',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showPersonalDataInfo() {
    return showAppBottomSheet<void>(
      context,
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Персональные данные',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              const Text(
                'При регистрации приложение обрабатывает имя, телефон или email, а также данные профиля и тренировок, которые вы вводите самостоятельно.',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 10),
              const Text(
                'Эти данные нужны для входа в аккаунт, ведения тренировочного журнала, графиков прогресса и связи атлета с тренером. Согласие оформлено в соответствии с Федеральным законом №152-ФЗ «О персональных данных».',
                style: TextStyle(height: 1.35),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: primaryButtonStyle(radius: 16),
                  child: const Text('Понятно'),
                ),
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
