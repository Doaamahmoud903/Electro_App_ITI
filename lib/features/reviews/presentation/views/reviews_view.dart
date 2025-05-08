import 'package:electro/features/reviews/presentation/views/widgets/reviews_view_body.dart';
import 'package:flutter/material.dart';

class ReviewsView extends StatelessWidget {
  final Map<String, dynamic> extra;

  const ReviewsView({super.key, required this.extra});

  @override
  Widget build(BuildContext context) {
    print("Extra $extra");

    return ReviewsViewBody(extra: extra);
  }
}
