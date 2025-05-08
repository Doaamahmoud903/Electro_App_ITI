import 'package:cached_network_image/cached_network_image.dart';
import 'package:electro/core/utils/assets_manager.dart';
import 'package:electro/core/widgets/custom_image.dart';
import 'package:electro/core/widgets/custom_loding_indicator.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.radius,
    this.fit,
    this.loadingSize,
    this.withLoading = true,
  });
  final String url;
  final double? width, height, loadingSize;
  final BorderRadiusGeometry? radius;
  final BoxFit? fit;
  final bool withLoading;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      height: height ?? 102,
      width: width ?? 102,
      imageUrl: url,
      errorWidget:
          (context, url, error) => const ClipOval(
            child: CustomImage(imagePath: ImagesAssets.errorImage),
          ),
      progressIndicatorBuilder:
          withLoading
              ? (context, url, progress) => SizedBox(
                width: (loadingSize ?? 170) + 10,
                child: Center(child: CustomLoadingIndicator(size: loadingSize)),
              )
              : null,
      imageBuilder:
          (context, imageProvider) => Container(
            width: width ?? 148,
            height: height ?? 131,
            decoration: BoxDecoration(
              borderRadius: radius ?? BorderRadius.circular(20),
              image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
              ),
            ),
          ),
    );
  }
}
