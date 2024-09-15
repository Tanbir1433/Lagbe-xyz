import 'package:ecommerce_user_app/screen/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_user_app/widget/custom_appbar/my_appbar.dart';
import '../../core/data/data_provider.dart';
import '../../../../widget/product_grid_view.dart';
import '../../models/user.dart';
import '../../utility/constants.dart';
import '../../widget/app_bar_action_button.dart';
import '../../widget/custome_searchbar/custom_search_bar.dart'; // Ensure correct import
import '../../widget/custome_searchbar/scroll_provider.dart';
import 'components/category_selector.dart';
import 'components/poster_section.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final scrollProvider = Provider.of<ScrollProvider>(context, listen: false);
    scrollProvider.onScroll(scrollController);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0.0,
        actions: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppBarActionButton(
                    icon: Icons.menu,
                    onPressed: () {
                      final box = GetStorage();
                      Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
                      User? userLogged = User.fromJson(userJson ?? {});
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                  Image.asset(
                    "assets/images/app_logo.png", // Replace with your logo asset
                    height: 40,
                  ),
                  AppBarActionButton(
                    icon: Icons.person,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Consumer<ScrollProvider>(
                  builder: (context, scrollProvider, _) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: scrollProvider.showSearchBar
                          ? 60
                          : 0, // Smooth height transition
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      child: scrollProvider.showSearchBar
                          ? CustomSearchBar(
                              controller:
                                  TextEditingController(), // Provide a controller
                              onChanged: (val) {
                                final dataProvider =
                                    context.read<DataProvider>();
                                dataProvider.filterProduct(val);
                              },
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                const PosterSection(),
                const SizedBox(height: 2),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return CategorySelector(
                      categories: dataProvider.categories,
                    );
                  },
                ),
                const SizedBox(height: 2),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return ProductGridView(
                      items: dataProvider.products,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
