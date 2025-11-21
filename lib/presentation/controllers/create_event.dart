import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/repositories/event.dart';
import '../../data/models/event.dart';

class CreateEventController extends GetxController {
  final EventsRepository _repository = EventsRepository();
  final ImagePicker _picker = ImagePicker();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var selectedImages = <XFile>[].obs;

  Future<void> pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (images.length + selectedImages.length > 5) {
        Get.snackbar('Error', 'Maximum 5 images allowed');
        return;
      }

      // Validate file sizes (5MB max)
      for (var image in images) {
        final bytes = await image.length();
        if (bytes > 5 * 1024 * 1024) {
          Get.snackbar('Error', 'Image ${image.name} exceeds 5MB');
          return;
        }
      }

      selectedImages.addAll(images);
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick images: ${e.toString()}');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image == null) return;

      if (selectedImages.length >= 5) {
        Get.snackbar('Error', 'Maximum 5 images allowed');
        return;
      }

      final bytes = await image.length();
      if (bytes > 5 * 1024 * 1024) {
        Get.snackbar('Error', 'Image exceeds 5MB');
        return;
      }

      selectedImages.add(image);
    } catch (e) {
      Get.snackbar('Error', 'Failed to capture image: ${e.toString()}');
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  Future<void> createEvent({
    required String title,
    required String description,
    required int scheduledAt,
    required String location,
    double? lat,
    double? lng,
    required String organizerName,
    required String organizerEmail,
    required String organizerPhone,
    required int attendeeLimit,
    required String userId,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // For now, we'll use placeholder image URLs
      // In production, you'd upload images first and get URLs
      final imageUrls = selectedImages.isNotEmpty
          ? ['https://via.placeholder.com/400x300']
          : <String>[];

      final event = EventModel(
        id: '',
        title: title,
        description: description,
        scheduledAt: scheduledAt,
        location: location,
        lat: lat,
        lng: lng,
        images: imageUrls,
        organizerName: organizerName,
        organizerEmail: organizerEmail,
        organizerPhone: organizerPhone,
        attendeeLimit: attendeeLimit,
        attendeeCount: 0,
        userId: userId,
        createdAt: DateTime.now().toIso8601String(),
      );

      await _repository.createEvent(event);

      Get.back();
      Get.snackbar('Success', 'Event created successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to create event: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    selectedImages.clear();
    errorMessage.value = '';
  }
}
