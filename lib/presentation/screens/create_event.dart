import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../data/repositories/event.dart';
import '../../data/models/event.dart';
import '../controllers/auth.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final repository = EventsRepository();
      final authController = Get.find<AuthController>();
      final userId = authController.currentUser.value?.id.toString() ?? '1';

      final event = EventModel(
        id: '',
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        scheduledAt:
            DateTime.now()
                .add(const Duration(days: 1))
                .millisecondsSinceEpoch ~/
            1000,
        location: _locationController.text.trim(),
        lat: null,
        lng: null,
        images: [],
        organizerName: 'Test Organizer',
        organizerEmail: 'test@example.com',
        organizerPhone: '',
        attendeeLimit: 100,
        attendeeCount: 0,
        userId: userId,
        createdAt: DateTime.now().toIso8601String(),
      );

      await repository.createEvent(event);

      Get.back();
      Get.snackbar('Success', 'Event created!');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Create Event', style: AppTextStyles.h2),
        backgroundColor: AppColors.surface,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.05),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: height * 0.02),

              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: height * 0.02),

              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: height * 0.04),

              SizedBox(
                width: double.infinity,
                height: height * 0.06,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Create',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
