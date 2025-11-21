import 'package:get/get.dart';
import '../../data/repositories/event.dart';
import '../../data/models/event.dart';

class EventsController extends GetxController {
  final EventsRepository _eventsRepository = EventsRepository();

  var isLoading = false.obs;
  var events = <EventModel>[].obs;
  var errorMessage = ''.obs;
  var currentPage = 1.obs;
  var hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Defer to avoid build phase issues
    Future.microtask(() => fetchEvents());
  }

  Future<void> fetchEvents({bool refresh = false}) async {
    if (refresh) {
      currentPage.value = 1;
      hasMore.value = true;
      events.clear();
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final newEvents = await _eventsRepository.getEvents(
        page: currentPage.value,
        limit: 10,
      );

      if (newEvents.isEmpty) {
        hasMore.value = false;
      } else {
        events.addAll(newEvents);
        currentPage.value++;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = e.toString();
    }
  }

  Future<void> refreshEvents() async {
    await fetchEvents(refresh: true);
  }

  Future<void> loadMoreEvents() async {
    if (!isLoading.value && hasMore.value) {
      await fetchEvents();
    }
  }
}
