import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/event.dart';

class EventDetailScreen extends StatelessWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Event Details', style: AppTextStyles.h3),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(event.title, style: AppTextStyles.h1),
            SizedBox(height: height * 0.02),

            // Date & Time
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: AppColors.primary,
                ),
                SizedBox(width: width * 0.03),
                Text(
                  '${event.getFormattedDate()} at ${event.getFormattedTime()}',
                  style: AppTextStyles.body,
                ),
              ],
            ),
            SizedBox(height: height * 0.015),

            // Location
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: AppColors.primary,
                ),
                SizedBox(width: width * 0.03),
                Expanded(
                  child: Text(event.location, style: AppTextStyles.body),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),

            // Attendees
            Row(
              children: [
                const Icon(Icons.people, size: 20, color: AppColors.primary),
                SizedBox(width: width * 0.03),
                Text(
                  '${event.attendeeCount} / ${event.attendeeLimit} registered',
                  style: AppTextStyles.body,
                ),
              ],
            ),
            SizedBox(height: height * 0.03),

            // Description
            Text('About Event', style: AppTextStyles.h2),
            SizedBox(height: height * 0.01),
            Text(
              event.description,
              style: AppTextStyles.body.copyWith(height: 1.5),
            ),
            SizedBox(height: height * 0.03),

            // Organizer
            Text('Organizer', style: AppTextStyles.h2),
            SizedBox(height: height * 0.01),
            Container(
              padding: EdgeInsets.all(width * 0.04),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.organizerName, style: AppTextStyles.h3),
                  if (event.organizerEmail.isNotEmpty) ...[
                    SizedBox(height: height * 0.01),
                    Text(event.organizerEmail, style: AppTextStyles.caption),
                  ],
                  if (event.organizerPhone.isNotEmpty) ...[
                    SizedBox(height: height * 0.008),
                    Text(event.organizerPhone, style: AppTextStyles.caption),
                  ],
                ],
              ),
            ),
            SizedBox(height: height * 0.03),

            // Register Button
            SizedBox(
              width: double.infinity,
              height: height * 0.06,
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar('Success', 'Registered for ${event.title}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Register for Event',
                  style: AppTextStyles.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
