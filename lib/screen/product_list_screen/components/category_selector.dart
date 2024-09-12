import '../../product_by_category_screen/product_by_category_screen.dart';
import '../../../utility/animation/open_container_wrapper.dart';
import 'package:flutter/material.dart';
import '../../../models/category.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;


  const CategorySelector({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 1),
            child: OpenContainerWrapper(
              nextScreen: ProductByCategoryScreen(selectedCategory: categories[index]),
              child: SizedBox(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 55,
                        width: 55,
                        child: Image.network(
                          category.image ?? '',
                          fit: BoxFit.scaleDown,
                          scale: 1,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error, color: Colors.grey);
                          },
                        ),
                      ),
                      Text(
                        category.name ?? '',
                        style: TextStyle(
                          color: category.isSelected ? Colors.white : Colors.black,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
