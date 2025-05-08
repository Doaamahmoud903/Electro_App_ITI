import 'package:electro/core/theming/color_manager.dart';
import 'package:electro/core/theming/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProfileDetails extends StatefulWidget {
  final String labelText;
  final String initialText;
  final ValueChanged<String> onChanged;
  final TextEditingController? textController;

  const UserProfileDetails({
    super.key,
    required this.labelText,
    required this.initialText,
    required this.onChanged,
    this.textController,
  });

  @override
  State<UserProfileDetails> createState() => _UserProfileDetailsState();
}

class _UserProfileDetailsState extends State<UserProfileDetails> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ?? TextEditingController();
    _controller.text = widget.initialText;
  }

  @override
  void didUpdateWidget(covariant UserProfileDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialText != _controller.text) {
      _controller.text = widget.initialText;
    }
  }

  @override
  void dispose() {
    // Only dispose the controller if we created it ourselves
    if (widget.textController == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool themeCondition = context.read<ThemeCubit>().isLightMode;
    Color colorCondition =
        themeCondition ? ColorsManager.primaryLight : ColorsManager.whiteColor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText,
            style: TextStyle(color: colorCondition, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 398,
            height: 50,
            child: TextField(
              controller: _controller,
              style: TextStyle(color: colorCondition, fontSize: 16),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: colorCondition, width: 0.8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: colorCondition, width: .8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: colorCondition, width: 0.8),
                ),
                suffixIcon: Icon(Icons.edit, color: colorCondition),
              ),
              onChanged: (value) {
                widget.onChanged(value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
