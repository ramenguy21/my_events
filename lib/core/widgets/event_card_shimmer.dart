import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../constants/app_colors.dart';

class EventCardShimmer extends StatelessWidget {
  const EventCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.textSecondary.withOpacity(0.1),
            highlightColor: AppColors.textSecondary.withOpacity(0.05),
            child: Container(
              height: height * 0.2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Shimmer.fromColors(
              baseColor: AppColors.textSecondary.withOpacity(0.1),
              highlightColor: AppColors.textSecondary.withOpacity(0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 16,
                    width: width * 0.6,
                    color: Colors.white,
                  ),
                  SizedBox(height: height * 0.01),
                  Container(
                    height: 12,
                    width: width * 0.8,
                    color: Colors.white,
                  ),
                  SizedBox(height: height * 0.008),
                  Container(
                    height: 12,
                    width: width * 0.5,
                    color: Colors.white,
                  ),
                  SizedBox(height: height * 0.015),
                  Container(
                    height: 12,
                    width: width * 0.4,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
