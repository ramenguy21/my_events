import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/models/event.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class EventCard extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTap;
  final VoidCallback? onFavorite;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.02),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: event.images.isNotEmpty
                      ? CachedNetworkImage(
                          imageUrl: event.images.first,
                          height: height * 0.2,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            height: height * 0.2,
                            color: AppColors.textSecondary.withOpacity(0.1),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            height: height * 0.2,
                            color: AppColors.textSecondary.withOpacity(0.1),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 50,
                            ),
                          ),
                        )
                      : Container(
                          height: height * 0.2,
                          color: AppColors.textSecondary.withOpacity(0.1),
                          child: const Center(
                            child: Icon(
                              Icons.event,
                              size: 50,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                ),
                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavorite,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.favorite_border,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Content
            Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: AppTextStyles.h3,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: height * 0.01),
                  Text(
                    event.description,
                    style: AppTextStyles.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: width * 0.02),
                      Text(
                        '${event.getFormattedDate()} • ${event.getFormattedTime()}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.008),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: Text(
                          event.location,
                          style: AppTextStyles.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    children: [
                      Icon(Icons.people, size: 16, color: AppColors.primary),
                      SizedBox(width: width * 0.02),
                      Text(
                        '${event.attendeeCount} attending',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
