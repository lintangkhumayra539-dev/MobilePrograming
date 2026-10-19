import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    required this.accounts,
    required this.onLoginSuccess,
    super.key,
  });

  final Map<String, String> accounts;
  final ValueChanged<String> onLoginSuccess;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isRegistering = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final username = _usernameController.text.trim();
    final normalizedUsername = username.toLowerCase();
    final password = _passwordController.text;

    if (_isRegistering) {
      if (widget.accounts.containsKey(normalizedUsername)) {
        _showMessage('Username sudah terdaftar.');
        return;
      }

      widget.accounts[normalizedUsername] = password;
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() {
        _isRegistering = false;
      });
      _showMessage('Akun berhasil dibuat. Silakan masuk.');
      return;
    }

    if (widget.accounts[normalizedUsername] != password) {
      _showMessage('Username atau password salah.');
      return;
    }

    widget.onLoginSuccess(username);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username wajib diisi.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi.';
    }
    if (_isRegistering && value.length < 6) {
      return 'Password minimal 6 karakter.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary.withValues(alpha: 0.12),
              colorScheme.surface,
              colorScheme.tertiary.withValues(alpha: 0.10),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/sevima_logo.png',
                            key: const Key('sevimaLogo'),
                            width: 112,
                            height: 112,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'SEVIMA',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  color: colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isRegistering ? 'Buat Akun' : 'Selamat Datang',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _isRegistering
                                ? 'Daftar untuk mulai menggunakan aplikasi.'
                                : 'Masuk menggunakan username dan password.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 28),
                          TextFormField(
                            key: const Key('usernameField'),
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            autofillHints: const [AutofillHints.username],
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person_outline),
                              border: OutlineInputBorder(),
                            ),
                            validator: _validateUsername,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            key: const Key('passwordField'),
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            textInputAction: _isRegistering
                                ? TextInputAction.next
                                : TextInputAction.done,
                            autofillHints: [
                              _isRegistering
                                  ? AutofillHints.newPassword
                                  : AutofillHints.password,
                            ],
                            onFieldSubmitted: (_) {
                              if (!_isRegistering) _submit();
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                tooltip: _isPasswordVisible
                                    ? 'Sembunyikan password'
                                    : 'Tampilkan password',
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                            validator: _validatePassword,
                          ),
                          if (_isRegistering) ...[
                            const SizedBox(height: 16),
                            TextFormField(
                              key: const Key('confirmPasswordField'),
                              controller: _confirmPasswordController,
                              obscureText: !_isPasswordVisible,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (_) => _submit(),
                              decoration: const InputDecoration(
                                labelText: 'Konfirmasi password',
                                prefixIcon: Icon(Icons.lock_reset),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Konfirmasi password wajib diisi.';
                                }
                                if (value != _passwordController.text) {
                                  return 'Password tidak sama.';
                                }
                                return null;
                              },
                            ),
                          ],
                          const SizedBox(height: 24),
                          FilledButton(
                            key: const Key('submitButton'),
                            onPressed: _submit,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text(
                              _isRegistering ? 'Daftar' : 'Masuk',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            key: const Key('toggleAuthModeButton'),
                            onPressed: () {
                              setState(() {
                                _isRegistering = !_isRegistering;
                              });
                              _formKey.currentState?.reset();
                            },
                            child: Text(
                              _isRegistering
                                  ? 'Sudah punya akun? Masuk'
                                  : 'Belum punya akun? Daftar',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
