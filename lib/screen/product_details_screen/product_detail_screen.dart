import 'package:ecommerce_user_app/utility/extensions.dart';

import '../../widget/expendeble_text.dart';
import 'provider/product_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/carousel_slider.dart';
import '../../../../widget/page_wrapper.dart';
import '../../models/product.dart';
import '../../widget/horizondal_list.dart';
import 'components/product_rating_section.dart';



class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: PageWrapper(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// product image section
                Container(
                  height: height * 0.42,
                  width: width,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE5E6E8),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                    ),
                  ),
                  child: CarouselSlider(items: product.images ?? []),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// product name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:250,
                            child: Text(
                              '${product.name}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          /// product rating section
                          const ProductRatingSection(),
                        ],
                      ),

                      const SizedBox(height: 10),
                      /// product rate , offer , stock section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.offerPrice != null ? "৳${product.offerPrice}" : "\$${product.price}",
                            style: const TextStyle(color: Color(0xFF9b59b6),fontSize: 20,fontWeight: FontWeight.w700),
                          ),
                          Visibility(
                            visible: product.offerPrice != product.price,
                            child: Text(
                              "৳ ${product.price}",
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text.rich(
                        TextSpan(
                          children: [
                            if (product.quantity != 0) ...[
                              const TextSpan(
                                text: "Available stock: ",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                              ),
                              TextSpan(
                                text: "${product.quantity}",
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.green),
                              ),
                            ] else ...[
                              const TextSpan(
                                text: "Not available",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.red),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      product.proVariantId!.isNotEmpty
                          ? Text(
                              'Available ${product.proVariantTypeId?.type}',
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black)
                            )
                          : const SizedBox(),
                      Consumer<ProductDetailProvider>(
                        builder: (context, proDetailProvider, child) {
                          return HorizontalList(
                            items: product.proVariantId ?? [],
                            itemToString: (val) => val,
                            selected: proDetailProvider.selectedVariant,
                            onSelect: (val) {
                              proDetailProvider.selectedVariant = val;
                              proDetailProvider.updateUI();
                            },
                          );
                        },
                      ),
                      /// product description
                      Text(
                        "Product Description",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 10),
                      ExpandableText(text: "${product.description}"),
                      const SizedBox(height: 40),
                      /// add to cart button
                      SizedBox(
                        height: 55,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9b59b6)
                          ),
                          onPressed: product.quantity != 0
                              ? () {
                                  context.proDetailProvider.addToCart(product);
                                }
                              : null,
                          child: const Text("Add to cart", style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
