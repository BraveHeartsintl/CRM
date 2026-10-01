import 'package:flutter/material.dart';
import '../models/business.dart';
import '../theme/app_theme.dart';
import '../widgets/common_widgets.dart';
import 'package_screen.dart';

class AssessmentScreen extends StatefulWidget {
  final Business business;

  const AssessmentScreen({super.key, required this.business});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int step = 0;

  final improve = <String>{};
  final sources = <String>{};
  final growthPlans = <String>{};
  final services = <String>{};
  String? planningGrow;
  String? yearsOperating;
  final challengeCtrl = TextEditingController();
  final ninetyDayCtrl = TextEditingController();

  @override
  void dispose() {
    challengeCtrl.dispose();
    ninetyDayCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _part(
        title: 'Part 1 — Business information',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _readOnly('Business name', widget.business.name),
            _readOnly('Owner / contact', widget.business.owner),
            _readOnly('Phone', widget.business.phone),
            _readOnly('Email', widget.business.email),
            _readOnly('Business type', widget.business.type.label),
            const SizedBox(height: 12),
            const Text('How long have you been operating?',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            ChoiceChips(
              multi: false,
              options: const [
                'Less than 1 year',
                '1–3 years',
                '3–5 years',
                '5–10 years',
                '10+ years',
              ],
              selected: {
                ?yearsOperating,
              },
              onToggle: (v) => setState(() => yearsOperating = v),
            ),
          ],
        ),
      ),
      _part(
        title: 'Part 2 — Online presence',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _readOnly(
              'Website',
              widget.business.website ?? 'No website',
            ),
            _readOnly(
              'Google Business Profile',
              widget.business.hasGoogleProfile ? 'Yes' : 'No / unknown',
            ),
            _readOnly(
              'Social media',
              widget.business.socialMedia.isEmpty
                  ? 'None'
                  : widget.business.socialMedia.join(', '),
            ),
            const SizedBox(height: 8),
            const Text(
              'Where do most of your customers come from?',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ChoiceChips(
              options: const [
                'Walk-ins',
                'Google',
                'Facebook',
                'Instagram',
                'TikTok',
                'Word of mouth',
                'Repeat customers',
                'Advertising',
              ],
              selected: sources,
              onToggle: (v) => setState(() {
                sources.contains(v) ? sources.remove(v) : sources.add(v);
              }),
            ),
          ],
        ),
      ),
      _part(
        title: 'Part 3 — What to improve',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What would you most like to improve?',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 4),
            const Text(
              'Let the owner tell you their problem.',
              style: TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 8),
            ChoiceChips(
              options: const [
                'More customers',
                'More phone enquiries',
                'More WhatsApp enquiries',
                'More bookings',
                'More online orders',
                'More Google reviews',
                'Better website',
                'Better social media',
                'Better advertising',
              ],
              selected: improve,
              onToggle: (v) => setState(() {
                improve.contains(v) ? improve.remove(v) : improve.add(v);
              }),
            ),
          ],
        ),
      ),
      _part(
        title: 'Part 4 — Growth',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you planning to grow the business?',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ChoiceChips(
              multi: false,
              options: const ['Yes', 'Maybe', 'No'],
              selected: {?planningGrow},
              onToggle: (v) => setState(() => planningGrow = v),
            ),
            const SizedBox(height: 16),
            const Text(
              'If yes, what are you considering?',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ChoiceChips(
              options: const [
                'More staff',
                'New equipment',
                'Refurbishment',
                'Larger premises',
                'Second location',
                'More stock',
                'Online expansion',
                'Delivery/ordering',
                'Marketing',
              ],
              selected: growthPlans,
              onToggle: (v) => setState(() {
                growthPlans.contains(v)
                    ? growthPlans.remove(v)
                    : growthPlans.add(v);
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: challengeCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Biggest challenge right now',
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
      _part(
        title: 'Part 5 — Services',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Which of these would be useful to you?',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            ChoiceChips(
              options: const [
                'New website',
                'Website improvements',
                'Google optimisation',
                'Social media',
                'Photography/video',
                'Online booking',
                'Online ordering',
                'Digital menu',
                'Advertising',
                'SEO',
                'Customer loyalty programme',
              ],
              selected: services,
              onToggle: (v) => setState(() {
                services.contains(v) ? services.remove(v) : services.add(v);
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: ninetyDayCtrl,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText:
                    'If we could improve one thing online in 90 days, what would it be?',
                alignLabelWithHint: true,
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Growth assessment'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                '${step + 1}/${pages.length}',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (step + 1) / pages.length,
            color: AppColors.forest,
            backgroundColor: AppColors.forestSoft,
            minHeight: 4,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
              children: [
                const Text(
                  'BRAVE HEARTS — LOCAL BUSINESS GROWTH ASSESSMENT',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: AppColors.forest,
                  ),
                ),
                const SizedBox(height: 12),
                pages[step],
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Row(
                children: [
                  if (step > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => step--),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          side: const BorderSide(color: AppColors.line),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  if (step > 0) const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.ember,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        if (step < pages.length - 1) {
                          setState(() => step++);
                          return;
                        }
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => PackageScreen(
                              business: widget.business,
                              selectedServices: services.toList(),
                              primaryGoal: improve.isEmpty
                                  ? null
                                  : improve.first,
                              challenge: challengeCtrl.text.trim().isEmpty
                                  ? null
                                  : challengeCtrl.text.trim(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        step < pages.length - 1 ? 'Next' : 'See recommended package',
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _part({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 14),
        child,
      ],
    );
  }

  Widget _readOnly(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
