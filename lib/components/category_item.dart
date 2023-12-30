import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.isCurrentCategories,
    required this.category,
  }) : super(key: key);

  final bool isCurrentCategories;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isCurrentCategories
              ? const Color(0xFF0ECF82)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          category,
          style: TextStyle(
              color: isCurrentCategories ? Colors.white : Colors.grey,
              fontSize: 12),
        ),
      ),
    );
  }
}
