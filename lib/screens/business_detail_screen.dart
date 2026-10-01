import 'package:flutter/material.dart';
import '../models/business.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'assessment_screen.dart';
import 'digital_audit_screen.dart';
import 'package_screen.dart';

class BusinessDetailScreen extends StatelessWidget {
  final Business business;

  const BusinessDetailScreen({super.key, required this.business});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(business.name)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.forest, AppColors.forestMid],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        business.name.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                    TempChip(temp: business.temperature),
                  ],
                ),
                const SizedBox(height: 10),
                _meta('Owner', business.owner),
                _meta('Category', business.type.label),
                _meta('Location', business.address),
                if (business.packageName != null)
                  _meta('Package', business.packageName!),
                if (business.monthlyRevenue != null)
                  _meta('Monthly revenue', '£${business.monthlyRevenue}'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: StageChip(stage: business.stage)),
              const SizedBox(width: 8),
              HealthDot(level: business.health.overall, size: 12),
              const SizedBox(width: 6),
              Text(
                'Digital: ${HealthDot(level: business.health.overall).label}',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Quick actions', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _ActionBtn(
                icon: Icons.health_and_safety_outlined,
                label: 'Digital audit',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DigitalAuditScreen(business: business),
                    ),
                  );
                },
              ),
              _ActionBtn(
                icon: Icons.assignment_outlined,
                label: 'Growth assessment',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AssessmentScreen(business: business),
                    ),
                  );
                },
              ),
              _ActionBtn(
                icon: Icons.card_giftcard_outlined,
                label: 'Package',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => PackageScreen(business: business),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 22),
          _block(
            title: 'Contacts',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📞 ${business.phone}'),
                const SizedBox(height: 4),
                Text('✉ ${business.email}'),
                if (business.website != null) ...[
                  const SizedBox(height: 4),
                  Text('🌐 ${business.website}'),
                ],
              ],
            ),
          ),
          if (business.services.isNotEmpty) ...[
            const SizedBox(height: 12),
            _block(
              title: 'Services',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: business.services
                    .map(
                      (s) => Chip(
                        avatar: const Icon(Icons.check, size: 16, color: AppColors.forest),
                        label: Text(s),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
          const SizedBox(height: 12),
          _block(
            title: 'Next action',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  business.nextAction,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  'Due ${_fmt(business.nextActionDate)}',
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          if (business.primaryGoal != null || business.mainChallenge != null) ...[
            const SizedBox(height: 12),
            _block(
              title: 'Customer objective',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (business.primaryGoal != null)
                    Text('Primary goal: ${business.primaryGoal}'),
                  if (business.mainChallenge != null) ...[
                    const SizedBox(height: 6),
                    Text('Main challenge: ${business.mainChallenge}'),
                  ],
                  if (business.financeInterest) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.emberSoft,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Potential finance conversation — route to specialist',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppColors.ember,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
          const SizedBox(height: 12),
          _block(
            title: 'Activity',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: business.activity
                  .map(
                    (a) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 6),
                            child: Icon(Icons.circle, size: 8, color: AppColors.forest),
                          ),
                          const SizedBox(width: 10),
                          Expanded(child: Text(a)),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _meta(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        '$k: $v',
        style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _block({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  String _fmt(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.line),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: AppColors.forest),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
