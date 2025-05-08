import 'package:electro/core/theming/color_manager.dart';
import 'package:flutter/material.dart';

class HomeCarousalItem extends StatefulWidget {
  final double left;
  final double right;
  final String img;
  const HomeCarousalItem({
    super.key,
    required this.left,
    required this.right,
    required this.img,
  });

  @override
  State<HomeCarousalItem> createState() => _HomeCarousalItemState();
}

class _HomeCarousalItemState extends State<HomeCarousalItem> {
  @override
  Widget build(BuildContext context) {
    // var themeProvider = Provider.of<ThemeProvider>(context);

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            widget.img,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Positioned(
          right: widget.right == 0 ? null : widget.right,
          left: widget.left == 0 ? null : widget.left,
          top: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "UP TO 25% OFF",
                style: TextStyle(color: ColorsManager.primary, fontSize: 18),
              ),
              Text(
                "For all Headphones ",
                style: TextStyle(color: ColorsManager.primary, fontSize: 14),
              ),
              Text(
                " AirPods &",
                style: TextStyle(color: ColorsManager.primary, fontSize: 14),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Shop Now",
                  style: TextStyle(color: ColorsManager.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
