import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../widgets/widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: const [
          NotificationCard(
            title: 'Upcoming Booking',
            message: 'Service appointment at AutoZone SL tomorrow, 10:30 AM.',
            icon: Icons.event_available_outlined,
            themeColor: AppColors.accentGreen,
          ),
          SizedBox(height: 12),
          NotificationCard(
            title: 'Exclusive Offer',
            message: 'Get 25% OFF on Full Interior Detailing at DriveCare Stations.',
            icon: Icons.local_offer_outlined,
            themeColor: AppColors.accentPurple,
          ),
          SizedBox(height: 12),
          NotificationCard(
            title: 'Service Due Soon',
            message: 'Your Honda Civic (ABC-1234) is due for an oil change in 350km or 12 days.',
            icon: Icons.warning_amber_rounded,
            themeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
