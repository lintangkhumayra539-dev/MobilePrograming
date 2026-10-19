import 'package:flutter/material.dart';
import 'package:tugas_control_flow/login.dart';
import 'package:tugas_control_flow/tugas_control_flow.dart';

void main() {
  runApp(const TugasControlFlowApp());
}

class TugasControlFlowApp extends StatefulWidget {
  const TugasControlFlowApp({super.key});

  @override
  State<TugasControlFlowApp> createState() => _TugasControlFlowAppState();
}

class _TugasControlFlowAppState extends State<TugasControlFlowApp> {
  final Map<String, String> _accounts = {};
  String? _loggedInUsername;

  final List<String> _hariList = const [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  String _selectedHari = 'Senin';

  @override
  Widget build(BuildContext context) {
    final hasil = getSeragamHari(_selectedHari);

    return MaterialApp(
      title: 'Tugas Control Flow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: _loggedInUsername == null
          ? LoginPage(
              accounts: _accounts,
              onLoginSuccess: (username) {
                setState(() {
                  _loggedInUsername = username;
                });
              },
            )
          : Scaffold(
              appBar: AppBar(
                title: const Text('Control Flow Web'),
                centerTitle: true,
                actions: [
                  IconButton(
                    tooltip: 'Keluar',
                    onPressed: () {
                      setState(() {
                        _loggedInUsername = null;
                      });
                    },
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Halo, $_loggedInUsername!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Pilih hari',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              initialValue: _selectedHari,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                              ),
                              items: _hariList
                                  .map(
                                    (hari) => DropdownMenuItem(
                                      value: hari,
                                      child: Text(hari),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedHari = value;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                color: Colors.indigo.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                hasil,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
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
    );
  }
}
