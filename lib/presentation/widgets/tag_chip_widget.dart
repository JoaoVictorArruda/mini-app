import 'package:flutter/material.dart';

class TagChipWidget extends StatelessWidget {
  const TagChipWidget({required this.tag});
  final String tag;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, label) = switch (tag) {
      'new' => (Colors.green.shade100, Colors.green.shade900, 'NEW'),
      'old' => (Colors.grey.shade200, Colors.grey.shade800, 'OLD'),
      'hot' => (Colors.red.shade100, Colors.red.shade900, 'HOT'),
      _ => (Colors.blueGrey.shade100, Colors.blueGrey.shade900, tag.toUpperCase()),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(label, style: TextStyle(color: fg, fontWeight: FontWeight.w700)),
    );
  }
}
