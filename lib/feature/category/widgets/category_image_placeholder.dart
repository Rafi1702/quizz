import 'package:flutter/material.dart';

class CategoryImagePlaceholder extends StatelessWidget {
  final String categoryTitle;
  const CategoryImagePlaceholder({required this.categoryTitle, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://placehold.co/400x150/jpg',
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                categoryTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
