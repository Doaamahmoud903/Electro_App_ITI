import 'package:electro/core/functions/capitalize_text.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/widgets/custom_cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final bool isCircle;

  const CategoryItem({
    super.key,
    required this.title,
    required this.image,
    this.isCircle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child:
              isCircle
                  ? ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(35)),
                    child: CustomCachedNetworkImage(
                      url: image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  )
                  : Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightBlue,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
        ),
        const SizedBox(height: 5),
        Text(
          CapitalizeText.capitalizeText(title),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
