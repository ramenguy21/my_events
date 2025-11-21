import '../services/event.dart';
import '../models/event.dart';

class EventsRepository {
  final EventsApiService _apiService = EventsApiService();

  Future<List<EventModel>> getEvents({int page = 1, int limit = 10}) async {
    try {
      final response = await _apiService.get(
        '/events',
        queryParams: {'page': page, 'limit': limit},
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => EventModel.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch events: ${e.toString()}');
    }
  }

  Future<EventModel> getEventById(String id) async {
    try {
      final response = await _apiService.get('/events/$id');
      return EventModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch event details: ${e.toString()}');
    }
  }

  Future<EventModel> createEvent(EventModel event) async {
    try {
      final response = await _apiService.post('/events', event.toJson());
      return EventModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create event: ${e.toString()}');
    }
  }

  Future<EventModel> updateEvent(String id, EventModel event) async {
    try {
      final response = await _apiService.put('/events/$id', event.toJson());
      return EventModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update event: ${e.toString()}');
    }
  }

  Future<void> deleteEvent(String id) async {
    try {
      await _apiService.delete('/events/$id');
    } catch (e) {
      throw Exception('Failed to delete event: ${e.toString()}');
    }
  }

  Future<void> registerForEvent(String eventId, String userId) async {
    try {
      await _apiService.post('/registrations', {
        'eventId': eventId,
        'userId': userId,
        'isFav': false,
      });
    } catch (e) {
      throw Exception('Failed to register for event: ${e.toString()}');
    }
  }

  Future<List<EventModel>> getUserEvents(String userId) async {
    try {
      final response = await _apiService.get(
        '/events',
        queryParams: {'userId': userId},
      );

      if (response.data is List) {
        return (response.data as List)
            .map((json) => EventModel.fromJson(json))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception('Failed to fetch user events: ${e.toString()}');
    }
  }
}
