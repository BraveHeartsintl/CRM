import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/business.dart';
import '../widgets/common_widgets.dart';
import 'business_detail_screen.dart';

class BusinessesScreen extends StatefulWidget {
  const BusinessesScreen({super.key});

  @override
  State<BusinessesScreen> createState() => _BusinessesScreenState();
}

class _BusinessesScreenState extends State<BusinessesScreen> {
  String query = '';
  LeadTemp? filterTemp;

  @override
  Widget build(BuildContext context) {
    final filtered = MockData.businesses.where((b) {
      final q = query.toLowerCase();
      final matchesQuery = q.isEmpty ||
          b.name.toLowerCase().contains(q) ||
          b.owner.toLowerCase().contains(q) ||
          b.type.label.toLowerCase().contains(q);
      final matchesTemp = filterTemp == null || b.temperature == filterTemp;
      return matchesQuery && matchesTemp;
    }).toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Businesses',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                TextField(
                  onChanged: (v) => setState(() => query = v),
                  decoration: const InputDecoration(
                    hintText: 'Search name, owner, type…',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All'),
                      selected: filterTemp == null,
                      onSelected: (_) => setState(() => filterTemp = null),
                    ),
                    ...LeadTemp.values.map(
                      (t) => ChoiceChip(
                        label: Text(t.label),
                        selected: filterTemp == t,
                        onSelected: (_) => setState(() => filterTemp = t),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              itemCount: filtered.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final b = filtered[i];
                return BusinessCard(
                  business: b,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BusinessDetailScreen(business: b),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
