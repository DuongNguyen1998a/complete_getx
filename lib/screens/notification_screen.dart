import 'package:flutter/material.dart';

/// Notification Api
import '../api/notification_api.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notification Screen',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              NotificationApi.showNotification(
                title: 'Hello world',
                body: 'Hello, my first notification here in android',
                payload: 'duong.nguyen',
              );
            },
            child: const Text('Simple Notification'),
          ),
          ElevatedButton(
            onPressed: () {
              NotificationApi.showScheduledNotification(
                title: 'Hello world',
                body: 'Hello, my first scheduled notification here in android',
                payload: 'duong.nguyen',
                scheduledDateTime:
                    DateTime.now().add(const Duration(seconds: 5)),
              );
            },
            child: const Text('Scheduled Notification'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Remove Notification'),
          ),
        ],
      ),
    );
  }
}
