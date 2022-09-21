
import 'package:url_launcher/url_launcher.dart';

class CommonAction {
  static void makeCall(String mobNo) {
    final Uri callLaunchUri = Uri(scheme: "tel", path: mobNo);
    launchUrl(callLaunchUri);
  }

  static void sendSms(String mobNo, String content) {
    final Uri smsLaunchUri = Uri(
      scheme: 'sms',
      path: mobNo,
      queryParameters: <String, String>{
        'body': content,
      },
    );
    launchUrl(smsLaunchUri);
  }

  static void sendEmail(String emailAddress, String subject, String body) {
    final Uri emailLaunchUri = Uri(
      scheme: 'email',
      path: emailAddress,
      queryParameters: <String, String>{
        'subject': Uri.encodeComponent(subject),
        'body': Uri.encodeComponent(body),
      },
    );
    launchUrl(emailLaunchUri);
  }

  static void launchWebsite(String webAddress) {
    final Uri _url = Uri.parse(webAddress);
    launchUrl(_url);
  }
}
