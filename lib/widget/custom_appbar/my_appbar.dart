import 'package:ecommerce_user_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../../core/data/data_provider.dart';
import '../../models/user.dart';
import '../../utility/constants.dart';
import '../app_bar_action_button.dart';
import '../custom_search_bar.dart';
import 'appbar_state.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final appBarState = Provider.of<AppBarState>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: appBarState.isSearching
            ? buildSearchBar(context, appBarState)
            : null,
        leading: appBarState.isSearching
            ? IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            appBarState.clearSearch();
          },
        )
            : null,
        actions: appBarState.isSearching
            ? []
            : [
          Expanded(
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
                  icon: Icons.search_sharp,
                  onPressed: () {
                    appBarState.toggleSearch();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchBar(BuildContext context, AppBarState appBarState) {
    return Row(
      children: [
        Expanded(
          child: CustomSearchBar(
            controller: appBarState.searchController,
            onChanged: (val) {
              final dataProvider = context.read<DataProvider>();
              dataProvider.filterProduct(val);
            },
          ),
        ),
      ],
    );
  }
}
