import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/business.dart';
import '../theme/app_theme.dart';

class PackageScreen extends StatelessWidget {
  final Business business;
  final List<String> selectedServices;
  final String? primaryGoal;
  final String? challenge;

  const PackageScreen({
    super.key,
    required this.business,
    this.selectedServices = const [],
    this.primaryGoal,
    this.challenge,
  });

  ServicePackage get recommended {
    final count = selectedServices.length;
    if (count >= 5) return MockData.packages[3];
    if (count >= 3) return MockData.packages[2];
    if (count >= 1) return MockData.packages[1];
    if (business.packageName == 'Business Growth') return MockData.packages[2];
    if (business.packageName == 'Growth') return MockData.packages[1];
    if (business.health.overall == HealthLevel.poor) return MockData.packages[2];
    return MockData.packages[1];
  }

  @override
  Widget build(BuildContext context) {
    final pack = recommended;

    return Scaffold(
      appBar: AppBar(title: const Text('Recommended package')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            business.name,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          const Text(
            'Pricing is suggested by the system — salespeople can\'t freely undercut.',
            style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          if (primaryGoal != null || challenge != null || selectedServices.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer objective',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  if (primaryGoal != null) ...[
                    const SizedBox(height: 8),
                    Text('Primary goal: $primaryGoal'),
                  ],
                  if (challenge != null && challenge!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text('Main challenge: $challenge'),
                  ],
                  if (selectedServices.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: selectedServices
                          .map((s) => Chip(label: Text(s)))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          Container(
            padding: const EdgeInsets.all(20),
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
                const Text(
                  'RECOMMENDED',
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  pack.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '£${pack.priceMonthly}/month',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                ...pack.includes.map(
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(i, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'All packages',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
          ),
          const SizedBox(height: 10),
          ...MockData.packages.map((p) {
            final selected = p.id == pack.id;
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected ? AppColors.forest : AppColors.line,
                  width: selected ? 1.8 : 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          p.name,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                        Text(
                          p.includes.take(3).join(' · '),
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '£${p.priceMonthly}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: selected ? AppColors.forest : AppColors.ink,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.ember,
              minimumSize: const Size.fromHeight(52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Proposal marked as sent for ${business.name} — £${pack.priceMonthly}/mo (static demo)',
                  ),
                ),
              );
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text(
              'Mark proposal sent',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              side: const BorderSide(color: AppColors.line),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Manager override would be required in live app'),
                ),
              );
            },
            child: const Text('Request price override'),
          ),
        ],
      ),
    );
  }
}
