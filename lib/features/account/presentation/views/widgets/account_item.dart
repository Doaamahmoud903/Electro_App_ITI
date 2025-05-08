import 'package:flutter/material.dart';

class AccountItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final String? trailingText;

  const AccountItem({
    super.key,
    required this.title,
    required this.onTap,
    this.trailingText,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineMedium),
            Row(
              children: [
                if (trailingText != null) ...[
                  Text(
                    trailingText!,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(width: width * 0.02),
                ],
                const Icon(
                  Icons.chevron_right,
                  size: 30,
                  color: Color.fromARGB(183, 0, 0, 0),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
