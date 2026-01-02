import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_navigation_bar.dart';
import '../../../shared/widgets/cta_button.dart';
import '../domain/contact_form_provider.dart';

/// Contact page with form and contact information
class ContactPage extends ConsumerWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final formState = ref.watch(contactFormProvider);

    return Scaffold(
      backgroundColor: AppTheme.offWhite,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: AppNavigationBar(),
          ),
          SliverToBoxAdapter(
            child: _ContactContent(
              isMobile: isMobile,
              formState: formState,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactContent extends ConsumerWidget {
  const _ContactContent({
    required this.isMobile,
    required this.formState,
  });

  final bool isMobile;
  final ContactFormState formState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 96,
        vertical: 64,
      ),
      child: Column(
        children: [
          // Header
          Text(
            'Get In Touch',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'We\'d love to hear from you. Send us a message!',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textLight,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 64),

          // Content Row
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _ContactForm(),
                ),
                const SizedBox(width: 48),
                Expanded(
                  child: _ContactInfo(),
                ),
              ],
            )
          else
            Column(
              children: [
                _ContactInfo(),
                const SizedBox(height: 48),
                _ContactForm(),
              ],
            ),
        ],
      ),
    );
  }
}

/// Contact form widget
class _ContactForm extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(contactFormProvider);
    final formNotifier = ref.read(contactFormProvider.notifier);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: formState.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Send us a Message',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 24),

              // Name Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person),
                ),
                initialValue: formState.name,
                onChanged: (value) => formNotifier.updateName(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Phone Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                initialValue: formState.phone,
                onChanged: (value) => formNotifier.updatePhone(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Message Field
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Message',
                  prefixIcon: Icon(Icons.message),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                initialValue: formState.message,
                onChanged: (value) => formNotifier.updateMessage(value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: formState.isSubmitting
                    ? null
                    : () => formNotifier.submitForm(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: formState.isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.white,
                        ),
                      )
                    : const Text('Send Message'),
              ),

              // Success/Error Message
              if (formState.submitMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: formState.isSuccess
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: formState.isSuccess ? Colors.green : Colors.red,
                    ),
                  ),
                  child: Text(
                    formState.submitMessage!,
                    style: TextStyle(
                      color: formState.isSuccess ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Contact information widget
class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Information',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),

            // Phone
            _ContactItem(
              icon: Icons.phone,
              title: 'Phone',
              content: AppConstants.phoneNumber,
              onTap: () {},
            ),
            const SizedBox(height: 24),

            // WhatsApp
            _ContactItem(
              icon: Icons.chat,
              title: 'WhatsApp',
              content: AppConstants.phoneNumber,
              onTap: () {},
            ),
            const SizedBox(height: 32),

            // CTAs
            const WhatsAppButton(),
            const SizedBox(height: 12),
            const CallButton(),
          ],
        ),
      ),
    );
  }
}

/// Contact item widget
class _ContactItem extends StatelessWidget {
  const _ContactItem({
    required this.icon,
    required this.title,
    required this.content,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.rosePinkLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppTheme.rosePink),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textLight,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

