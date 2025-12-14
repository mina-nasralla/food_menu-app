import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/config/routing/route_constants.dart';

class SubscriptionPlan {
  final String id;
  final String name;
  final String price;
  final String period;
  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.features,
  });
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  // ignore: unused_field
  String? _phoneNumber;

  // ignore: unused_field
  String? _countryCode;

  String? _selectedPlanId;

  final List<SubscriptionPlan> _plans = const [
    SubscriptionPlan(
      id: 'basic',
      name: 'Basic',
      price: '\$9.99',
      period: '/month',
      features: ['1 Restaurant Branch', 'Basic Analytics', 'up to 50 items'],
    ),
    SubscriptionPlan(
      id: 'pro',
      name: 'Pro',
      price: '\$29.99',
      period: '/month',
      features: [
        '3 Restaurant Branches',
        'Advanced Analytics',
        'Unlimited items',
        'Priority Support',
      ],
    ),
    SubscriptionPlan(
      id: 'enterprise',
      name: 'Enterprise',
      price: 'Custom',
      period: '',
      features: [
        'Unlimited Branches',
        'Dedicated Manager',
        'Custom Integration',
        'White Labeling',
      ],
    ),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      if (_selectedPlanId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a subscription plan')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registering with Plan: $_selectedPlanId'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigate to Dashboard
      context.go(RouteConstants.adminDashboardPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Responsive Layout Builder
    return Scaffold(
      appBar: AppBar(title: const Text('New Chief Registration')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Join Us!',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Create an account to start managing',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone Field
                    IntlPhoneField(
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      initialCountryCode: 'EG',
                      onChanged: (phone) {
                        _phoneNumber = phone.completeNumber;
                        _countryCode = phone.countryCode;
                      },
                      onCountryChanged: (country) {
                        _countryCode = country.dialCode;
                      },
                      invalidNumberMessage: 'Invalid Phone Number',
                    ),
                    const SizedBox(height: 24),

                    // Subscription Plans Title
                    Text(
                      'Choose your plan',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Plans List
                    ..._plans.map((plan) => _buildPlanCard(plan, theme)),

                    const SizedBox(height: 32),

                    // Register Button
                    ElevatedButton(
                      onPressed: _register,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
    );
  }

  Widget _buildPlanCard(SubscriptionPlan plan, ThemeData theme) {
    final isSelected = _selectedPlanId == plan.id;
    final borderColor = isSelected
        ? theme.colorScheme.primary
        : Colors.grey.withOpacity(0.3);
    final backgroundColor = isSelected
        ? theme.colorScheme.primary.withOpacity(0.05)
        : null;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlanId = plan.id;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? theme.colorScheme.primary : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: plan.price,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          TextSpan(
                            text: plan.period,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: theme.colorScheme.primary,
                    size: 28,
                  )
                else
                  Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.grey,
                    size: 28,
                  ),
              ],
            ),
            const Divider(height: 24),
            ...plan.features.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Icon(Icons.check, size: 16, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(feature, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
