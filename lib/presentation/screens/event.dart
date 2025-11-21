import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/models/event.dart';
import '../../data/repositories/event.dart';
import '../controllers/auth.dart';
import '../controllers/event.dart';

class EventDetailScreen extends StatefulWidget {
  final EventModel event;

  const EventDetailScreen({super.key, required this.event});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isRegistering = false;
  late EventModel currentEvent;

  @override
  void initState() {
    super.initState();
    currentEvent = widget.event;
  }

  Future<void> _registerForEvent() async {
    setState(() => isRegistering = true);

    // Optimistic update
    final previousCount = currentEvent.attendeeCount;
    setState(() {
      currentEvent = currentEvent.copyWith(
        attendeeCount: currentEvent.attendeeCount + 1,
      );
    });

    try {
      final repository = EventsRepository();
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id.toString() ?? '1';

      await repository.registerForEvent(currentEvent.id, userId);

      // Update in events list if controller exists
      try {
        final eventsController = Get.find<EventsController>();
        final index = eventsController.events.indexWhere(
          (e) => e.id == currentEvent.id,
        );
        if (index != -1) {
          eventsController.events[index] = currentEvent;
        }
      } catch (e) {
        // Controller not found, that's okay
      }

      // Show success dialog
      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      // Revert optimistic update on error
      if (mounted) {
        setState(() {
          currentEvent = currentEvent.copyWith(attendeeCount: previousCount);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to register: ${e.toString()}'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => isRegistering = false);
      }
    }
  }

  void _showSuccessDialog() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: EdgeInsets.all(width * 0.06),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(width * 0.04),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle,
                  size: 60,
                  color: AppColors.success,
                ),
              ),
              SizedBox(height: height * 0.02),
              Text('Registration Successful!', style: AppTextStyles.h2),
              SizedBox(height: height * 0.01),
              Text(
                'You have successfully registered for ${currentEvent.title}',
                style: AppTextStyles.caption,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: height * 0.03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Got it!',
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
      ),
    );
  }

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
            Text(currentEvent.title, style: AppTextStyles.h1),
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
                  '${currentEvent.getFormattedDate()} at ${currentEvent.getFormattedTime()}',
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
                  child: Text(currentEvent.location, style: AppTextStyles.body),
                ),
              ],
            ),
            SizedBox(height: height * 0.015),

            // Attendees (with optimistic update)
            Row(
              children: [
                const Icon(Icons.people, size: 20, color: AppColors.primary),
                SizedBox(width: width * 0.03),
                Text(
                  '${currentEvent.attendeeCount} / ${currentEvent.attendeeLimit} registered',
                  style: AppTextStyles.body,
                ),
              ],
            ),
            SizedBox(height: height * 0.03),

            // Description
            Text('About Event', style: AppTextStyles.h2),
            SizedBox(height: height * 0.01),
            Text(
              currentEvent.description,
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
                  Text(currentEvent.organizerName, style: AppTextStyles.h3),
                  if (currentEvent.organizerEmail.isNotEmpty) ...[
                    SizedBox(height: height * 0.01),
                    Text(
                      currentEvent.organizerEmail,
                      style: AppTextStyles.caption,
                    ),
                  ],
                  if (currentEvent.organizerPhone.isNotEmpty) ...[
                    SizedBox(height: height * 0.008),
                    Text(
                      currentEvent.organizerPhone,
                      style: AppTextStyles.caption,
                    ),
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
                onPressed: isRegistering ? null : _registerForEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isRegistering
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                    : Text(
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
