import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../widgets/widgets.dart';

class AdminNotificationsScreen extends StatelessWidget {
  const AdminNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Broadcast Offers', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'New Notification',
              subtitle: 'Send alerts to all registered customers via Firebase Cloud Messaging',
            ),
            const SizedBox(height: 32),
            const AppTextField(
              label: 'Notification Title',
              hint: 'e.g. Exclusive Weekend Offer!',
              icon: Icons.title,
            ),
            const SizedBox(height: 20),
            const AppTextField(
              label: 'Message Content',
              hint: 'Enter the details of the promotion or alert...',
              icon: Icons.message_outlined,
            ),
            const SizedBox(height: 48),
            AppButton(
              text: 'Send Broadcast',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notification broadcast sent successfully!')),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
