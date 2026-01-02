import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

/// Primary CTA Button for WhatsApp booking
class WhatsAppButton extends StatelessWidget {
  const WhatsAppButton({
    super.key,
    this.message,
    this.label = 'Book on WhatsApp',
  });

  final String? message;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SizedBox(
      width: isMobile ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: () => _launchWhatsApp(message),
        icon: const Icon(Icons.chat, size: 20),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.rosePink,
          foregroundColor: AppTheme.white,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 32,
            vertical: 16,
          ),
          minimumSize: Size(isMobile ? double.infinity : 0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp(String? message) async {
    final url = AppConstants.getWhatsAppUrl(message);
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Secondary CTA Button for phone calls
class CallButton extends StatelessWidget {
  const CallButton({
    super.key,
    this.label = 'Call Now',
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SizedBox(
      width: isMobile ? double.infinity : null,
      child: OutlinedButton.icon(
        onPressed: () => _launchPhone(),
        icon: const Icon(Icons.phone, size: 20),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.rosePink,
          side: const BorderSide(color: AppTheme.rosePink, width: 2),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 32,
            vertical: 16,
          ),
          minimumSize: Size(isMobile ? double.infinity : 0, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Future<void> _launchPhone() async {
    final url = AppConstants.getPhoneUrl();
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

