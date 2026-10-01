import 'package:flutter/material.dart';
import '../models/business.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'digital_audit_screen.dart';

class AddBusinessScreen extends StatefulWidget {
  const AddBusinessScreen({super.key});

  @override
  State<AddBusinessScreen> createState() => _AddBusinessScreenState();
}

class _AddBusinessScreenState extends State<AddBusinessScreen> {
  final nameCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final ownerCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final websiteCtrl = TextEditingController();

  BusinessType type = BusinessType.restaurant;
  bool hasGoogle = false;
  final social = <String>{};

  @override
  void dispose() {
    nameCtrl.dispose();
    addressCtrl.dispose();
    ownerCtrl.dispose();
    phoneCtrl.dispose();
    emailCtrl.dispose();
    websiteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add business')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          const Text(
            'Create a business in under 2 minutes',
            style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nameCtrl,
            decoration: const InputDecoration(labelText: 'Business name'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<BusinessType>(
            initialValue: type,
            decoration: const InputDecoration(labelText: 'Business type'),
            items: BusinessType.values
                .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
                .toList(),
            onChanged: (v) => setState(() => type = v ?? type),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: addressCtrl,
            decoration: const InputDecoration(labelText: 'Address'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: ownerCtrl,
            decoration: const InputDecoration(labelText: 'Owner / manager'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: phoneCtrl,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: emailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: websiteCtrl,
            decoration: const InputDecoration(labelText: 'Website (optional)'),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Google Business Profile found'),
            value: hasGoogle,
            activeThumbColor: AppColors.forest,
            onChanged: (v) => setState(() => hasGoogle = v),
          ),
          const SizedBox(height: 8),
          const Text('Social media', style: TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          ChoiceChips(
            options: const [
              'Facebook',
              'Instagram',
              'TikTok',
              'YouTube',
              'LinkedIn',
              'None',
            ],
            selected: social,
            onToggle: (opt) {
              setState(() {
                if (social.contains(opt)) {
                  social.remove(opt);
                } else {
                  social.add(opt);
                }
              });
            },
          ),
          const SizedBox(height: 28),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.ember,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              final draft = Business(
                id: 'new',
                name: nameCtrl.text.trim().isEmpty
                    ? 'New Business'
                    : nameCtrl.text.trim(),
                type: type,
                address: addressCtrl.text.trim().isEmpty
                    ? 'Address pending'
                    : addressCtrl.text.trim(),
                owner: ownerCtrl.text.trim().isEmpty
                    ? 'Owner pending'
                    : ownerCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                email: emailCtrl.text.trim(),
                website: websiteCtrl.text.trim().isEmpty
                    ? null
                    : websiteCtrl.text.trim(),
                hasGoogleProfile: hasGoogle,
                socialMedia: social.toList(),
                stage: PipelineStage.newLead,
                temperature: LeadTemp.warm,
                health: DigitalHealth(
                  website: websiteCtrl.text.trim().isEmpty
                      ? HealthLevel.poor
                      : HealthLevel.needsWork,
                  google: hasGoogle ? HealthLevel.needsWork : HealthLevel.poor,
                  social: social.isEmpty || social.contains('None')
                      ? HealthLevel.poor
                      : HealthLevel.needsWork,
                  acquisition: HealthLevel.needsWork,
                  growth: HealthLevel.needsWork,
                ),
                nextAction: 'Complete digital audit',
                nextActionDate: DateTime.now(),
                services: const [],
                activity: const ['Just added from field visit'],
                territory: 'Current territory',
              );

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Saved locally (static demo) — opening digital audit'),
                ),
              );

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => DigitalAuditScreen(business: draft),
                ),
              );
            },
            child: const Text(
              'Save & start digital audit',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
