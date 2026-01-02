/// App-wide constants for Pooja's Makeover Fashion Artist
class AppConstants {
  AppConstants._();

  // Business Information
  static const String businessName = "Pooja's Makeover Fashion Artist";
  static const String tagline = "Your Perfect Bridal Look Awaits";
  static const String phoneNumber = "8838637951";
  static const String whatsappNumber = "918838637951"; // With country code for WhatsApp

  // WhatsApp Deep Link
  static String getWhatsAppUrl([String? message]) {
    final defaultMessage = "Hello! I'm interested in booking a makeup service.";
    final encodedMessage = Uri.encodeComponent(message ?? defaultMessage);
    return "https://wa.me/$whatsappNumber?text=$encodedMessage";
  }

  // Phone Call Deep Link
  static String getPhoneUrl() => "tel:$phoneNumber";

  // Routes
  static const String homeRoute = '/';
  static const String servicesRoute = '/services';
  static const String galleryRoute = '/gallery';
  static const String contactRoute = '/contact';
}

