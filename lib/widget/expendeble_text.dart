import 'package:flutter/material.dart';

class ExpandableText extends StatelessWidget {
  final String text;
  final ValueNotifier<bool> isExpanded = ValueNotifier<bool>(false); // External state management

  ExpandableText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ValueListenableBuilder(
          valueListenable: isExpanded,
          builder: (context, value, child) {
            return Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              maxLines: value ? null : 2, // Show full text if expanded, else 2 lines
              overflow: value ? TextOverflow.visible : TextOverflow.ellipsis,
            );
          },
        ),
        InkWell(
          onTap: () {
            isExpanded.value = !isExpanded.value; // Toggle expansion
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder(
                valueListenable: isExpanded,
                builder: (context, value, child) {
                  return Text(
                    value ? "Show less" : "Read more",
                    style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w700),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: isExpanded,
                builder: (context, value, child) {
                  return Icon(
                    value ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Colors.black54,
                    size: 20,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
