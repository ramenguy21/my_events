import 'package:get/get.dart';
import '../../data/repositories/event.dart';
import '../../data/models/event.dart';

class EventDetailController extends GetxController {
  final EventsRepository _eventsRepository = EventsRepository();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  Rx<EventModel?> event = Rx<EventModel?>(null);

  void loadEvent(EventModel eventData) {
    event.value = eventData;
  }

  Future<void> registerForEvent(String userId) async {
    if (event.value == null) return;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _eventsRepository.registerForEvent(event.value!.id, userId);

      // Update attendee count locally
      event.value = event.value!.copyWith(
        attendeeCount: event.value!.attendeeCount + 1,
      );

      Get.snackbar(
        'Success',
        'Successfully registered for ${event.value!.title}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar(
        'Error',
        'Failed to register: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
