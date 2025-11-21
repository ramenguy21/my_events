import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:my_events/presentation/screens/event.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/event_card.dart';
import '../../core/widgets/event_card_shimmer.dart';
import '../controllers/auth.dart';
import '../controllers/event.dart';
import 'create_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController _authController = Get.find<AuthController>();
  late final EventsController _eventsController;

  @override
  void initState() {
    super.initState();
    _eventsController = Get.put(EventsController());
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const CreateEventScreen()),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Events', style: AppTextStyles.h2),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.textPrimary),
            onPressed: () => _authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (_eventsController.isLoading.value &&
            _eventsController.events.isEmpty) {
          return ListView.builder(
            padding: EdgeInsets.all(width * 0.04),
            itemCount: 5,
            itemBuilder: (context, index) => const EventCardShimmer(),
          );
        }

        if (_eventsController.errorMessage.value.isNotEmpty &&
            _eventsController.events.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 60,
                  color: AppColors.error,
                ),
                SizedBox(height: height * 0.02),
                Text('Failed to load events', style: AppTextStyles.h3),
                SizedBox(height: height * 0.01),
                Text(
                  _eventsController.errorMessage.value,
                  style: AppTextStyles.caption,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: height * 0.03),
                ElevatedButton(
                  onPressed: () => _eventsController.refreshEvents(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Retry',
                    style: AppTextStyles.body.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => _eventsController.refreshEvents(),
          child: ListView.builder(
            padding: EdgeInsets.all(width * 0.04),
            itemCount: _eventsController.events.length + 1,
            itemBuilder: (context, index) {
              if (index == _eventsController.events.length) {
                if (_eventsController.hasMore.value &&
                    !_eventsController.isLoading.value) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _eventsController.loadMoreEvents();
                  });
                }
                return _eventsController.hasMore.value
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: height * 0.02),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : const SizedBox.shrink();
              }

              final event = _eventsController.events[index];
              return EventCard(
                event: event,
                onTap: () {
                  try {
                    Get.to(() => EventDetailScreen(event: event));
                  } catch (e) {
                    Get.snackbar('Error', 'Could not open event details.');
                  }
                },
                onFavorite: () {
                  Get.snackbar(
                    'Favorite',
                    'Toggle favorite for ${event.title}',
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
