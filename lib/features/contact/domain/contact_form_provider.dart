import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_constants.dart';

/// Contact form state
class ContactFormState {
  ContactFormState({
    this.name = '',
    this.phone = '',
    this.message = '',
    this.isSubmitting = false,
    this.submitMessage,
    this.isSuccess = false,
    GlobalKey<FormState>? formKey,
  }) : formKey = formKey ?? GlobalKey<FormState>();

  final String name;
  final String phone;
  final String message;
  final bool isSubmitting;
  final String? submitMessage;
  final bool isSuccess;
  final GlobalKey<FormState> formKey;

  ContactFormState copyWith({
    String? name,
    String? phone,
    String? message,
    bool? isSubmitting,
    String? submitMessage,
    bool? isSuccess,
    GlobalKey<FormState>? formKey,
  }) {
    return ContactFormState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      message: message ?? this.message,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitMessage: submitMessage ?? this.submitMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      formKey: formKey ?? this.formKey,
    );
  }
}

/// Contact form provider using Riverpod
class ContactFormNotifier extends StateNotifier<ContactFormState> {
  ContactFormNotifier() : super(ContactFormState());

  void updateName(String value) {
    state = state.copyWith(name: value);
  }

  void updatePhone(String value) {
    state = state.copyWith(phone: value);
  }

  void updateMessage(String value) {
    state = state.copyWith(message: value);
  }

  Future<void> submitForm(BuildContext context) async {
    if (!state.formKey.currentState!.validate()) {
      return;
    }

    state = state.copyWith(isSubmitting: true, submitMessage: null);

    try {
      // Create WhatsApp message with form data
      final message = '''
Hello! I'm interested in booking a service.

Name: ${state.name}
Phone: ${state.phone}

Message: ${state.message}
''';

      // Open WhatsApp with pre-filled message
      final url = AppConstants.getWhatsAppUrl(message);
      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        state = state.copyWith(
          isSubmitting: false,
          isSuccess: true,
          submitMessage: 'Message sent successfully! We\'ll get back to you soon.',
        );

        // Clear form after successful submission
        Future.delayed(const Duration(seconds: 2), () {
          state = ContactFormState();
        });
      } else {
        throw Exception('Could not launch WhatsApp');
      }
    } catch (e) {
      state = state.copyWith(
        isSubmitting: false,
        isSuccess: false,
        submitMessage: 'Failed to send message. Please try again or call us directly.',
      );
    }
  }
}

/// Provider for contact form
final contactFormProvider =
    StateNotifierProvider<ContactFormNotifier, ContactFormState>(
  (ref) => ContactFormNotifier(),
);

