import 'package:flutter/material.dart';
import 'screens/shell_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BraveHeartsCrmApp());
}

class BraveHeartsCrmApp extends StatelessWidget {
  const BraveHeartsCrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brave Hearts CRM',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const ShellScreen(),
    );
  }
}
