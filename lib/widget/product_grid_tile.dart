import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../screen/product_favorite_screen/provider/favorite_provider.dart';
import '../utility/extensions.dart';
import '../utility/utility_extention.dart';
import 'custom_network_image.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;
  final int index;
  final bool isPriceOff;

  const ProductGridTile({
    super.key,
    required this.product,
    required this.index,
    required this.isPriceOff,
  });

  @override
  Widget build(BuildContext context) {
    double discountPercentage =
        context.dataProvider.calculateDiscountPercentage(product.price ?? 0, product.offerPrice ?? 0);
    return GridTile(
      header: Padding(
        padding: const EdgeInsets.only(left: 10.0,top: 5,right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Visibility(
              visible: discountPercentage != 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                width: 80,
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  "OFF ${discountPercentage.toInt()} %",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, child) {
                return IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white
                  ),
                  icon:  Icon(
                    Icons.favorite,
                    color: favoriteProvider.checksIsItemFavorite(product.sId ?? '') ? Colors.red : const Color(0xFFA6A3A0),
                  ),
                  onPressed: () {
                    context.favoriteProvider.updateToFavoriteList(product.sId ?? '');
                  },
                );
              },
            ),
          ],
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  product.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                    fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      product.offerPrice != 0 ? "৳ ${product.offerPrice}" : "\$${product.price}",
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 3),
                  if (product.offerPrice != null && product.offerPrice != product.price)
                    Flexible(
                      child: Text(
                        "৳ ${product.price}",
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              )

            ],
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFE5E6E8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: CustomNetworkImage(
          imageUrl: product.images!.isNotEmpty ? product.images?.safeElementAt(0)?.url ?? '' : '',
          fit: BoxFit.scaleDown,
          scale: 2.6,
        ),
      ),
    );
  }
}
