import 'package:electro/core/functions/capitalize_text.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String image;
  final double? price;

  const ProductItem({
    super.key,
    required this.title,
    required this.image,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.lightPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: CustomCachedNetworkImage(
                url: image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              CapitalizeText.capitalizeText(title),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
