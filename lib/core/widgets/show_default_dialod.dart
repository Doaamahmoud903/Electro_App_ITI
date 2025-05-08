import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/styles_manager.dart';
import 'package:electro/core/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum NotificationType { error, success, warning, info }

void showDefaultDialog(
  BuildContext context, {
  required NotificationType type,
  String? title,
  VoidCallback? onProgressFinished,
  required String description,
}) {
  switch (type) {
    case NotificationType.error:
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              buttonPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 80,
                ),
                height: 534,
                width: 326,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SvgPicture.asset(IconsAssets.x),
                    // Text(title ?? StringManager.oops.tr(context),
                    Text(title ?? 'oops', style: Styles.textStyle24w7),
                    Text(
                      description,
                      style: Styles.textStyle16w4.copyWith(
                        color: ColorsManager.grey2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CustomButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      margin: EdgeInsets.zero,
                      textColor: Colors.white,
                      text: 'ok',
                      // text: StringManager.ok.tr(context),
                    ),
                  ],
                ),
              ),
            ),
      );
      break;
    case NotificationType.success:
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              buttonPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 80,
                ),
                height: 534,
                width: 326,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // SvgPicture.asset(IconsAssets.check),
                    // Text(title ?? StringManager.wellDone.tr(context),
                    Text(title ?? 'well done', style: Styles.textStyle24w7),
                    Text(
                      description,
                      style: Styles.textStyle16w4.copyWith(
                        color: ColorsManager.grey2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CustomButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      margin: EdgeInsets.zero,
                      textColor: Colors.white,
                      // text: StringManager.continueText.tr(context),
                      text: 'continue',
                    ),
                  ],
                ),
              ),
            ),
      );
      break;
    case NotificationType.info:
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              buttonPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 80,
                ),
                height: 534,
                width: 326,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      CupertinoIcons.info,
                      color: Colors.lightBlue,
                      size: 135,
                    ),
                    // Text(title ?? StringManager.noteII.tr(context),
                    Text(title ?? 'note', style: Styles.textStyle24w7),
                    Text(
                      description,
                      style: Styles.textStyle16w4.copyWith(
                        color: ColorsManager.grey2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CustomButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      margin: EdgeInsets.zero,
                      textColor: Colors.white,
                      // text: StringManager.ok.tr(context),
                      text: 'ok',
                    ),
                  ],
                ),
              ),
            ),
      );
      break;
    default:
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              shadowColor: Colors.transparent,
              buttonPadding: EdgeInsets.zero,
              content: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 80,
                ),
                height: 534,
                width: 326,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      CupertinoIcons.info,
                      color: Colors.lightBlue,
                      size: 135,
                    ),
                    // Text(title ?? StringManager.note.tr(context),
                    Text(title ?? 'note', style: Styles.textStyle24w7),
                    Text(
                      description,
                      style: Styles.textStyle16w4.copyWith(
                        color: ColorsManager.grey2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    CustomButton(
                      onPressed: () => GoRouter.of(context).pop(),
                      margin: EdgeInsets.zero,
                      textColor: Colors.white,
                      // text: StringManager.ok.tr(context),
                      text: 'ok',
                    ),
                  ],
                ),
              ),
            ),
      );
      break;
  }
}
