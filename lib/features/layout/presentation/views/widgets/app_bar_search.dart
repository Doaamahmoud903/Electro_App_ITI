import 'package:electro/core/localization/app_localization.dart';
import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:electro/core/utils/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarSearch extends StatefulWidget {
  final TextEditingController searchController;
  final VoidCallback onSearchSubmitted;
  final String? hintText;

  const AppBarSearch({
    super.key,
    this.hintText,
    required this.searchController,
    required this.onSearchSubmitted,
  });

  @override
  State<AppBarSearch> createState() => _AppBarSearchState();
}

class _AppBarSearchState extends State<AppBarSearch> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    final hintText = widget.hintText ?? StringManager.searchHint.tr(context);

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: themeCondition ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isFocused ? ColorsManager.primary : Colors.grey.shade400,
            width: 1.5,
          ),
          boxShadow:
              isFocused
                  ? [
                    BoxShadow(
                      color: ColorsManager.primary.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ]
                  : [],
        ),
        child: Focus(
          onFocusChange: (hasFocus) {
            setState(() => isFocused = hasFocus);
          },
          child: TextField(
            style: TextStyle(
              color:
                  themeCondition
                      ? ColorsManager.primaryDark
                      : ColorsManager.whiteColor,
              fontSize: 16,
            ),
            controller: widget.searchController,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontSize: 14,
                color:
                    themeCondition
                        ? ColorsManager.grey3
                        : ColorsManager.whiteColor,
              ),
              prefixIcon: Icon(
                Icons.search,
                color:
                    themeCondition
                        ? ColorsManager.primary
                        : ColorsManager.whiteColor,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.searchController.text.isNotEmpty)
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color:
                            themeCondition
                                ? ColorsManager.grey
                                : ColorsManager.whiteColor,
                      ),
                      onPressed: () {
                        widget.searchController.clear();
                        setState(() {});
                      },
                    ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color:
                          themeCondition
                              ? ColorsManager.primary
                              : ColorsManager.whiteColor,
                    ),
                    onPressed: widget.onSearchSubmitted,
                  ),
                ],
              ),
              border: InputBorder.none,
            ),
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => widget.onSearchSubmitted(),
          ),
        ),
      ),
    );
  }
}
