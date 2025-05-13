import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.download),
        label: const Text("Скачать Cultivator"),
        onPressed: () {
          launchUrl(
            Uri.parse('#'),
            mode: LaunchMode.externalApplication,
          );
        },
      ),
    );
  }
}
