import '../../../core/data/data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../../../models/product.dart';
import '../../../utility/constants.dart';


class FavoriteProvider extends ChangeNotifier {
  final DataProvider _dataProvider;
  final box = GetStorage();
  List<Product>  favoriteProduct = [];
  FavoriteProvider(this._dataProvider);


///Update To Favorite List
  updateToFavoriteList(String productId){
    List<dynamic> favouriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    if(favouriteList.contains(productId)){
      favouriteList.remove(productId);
    }else{
      favouriteList.add(productId);
    }
    checksIsItemFavorite(productId);
    box.write(FAVORITE_PRODUCT_BOX, favouriteList);
    loadFavoriteItems();
    notifyListeners();

  }

  /// Check Is Favorite Items
  bool checksIsItemFavorite(String productId) {
    List<dynamic> favoriteList = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    bool isExist = favoriteList.contains(productId);
    return isExist;
  }

  /// load Favorite Items
  void loadFavoriteItems() {
    List<dynamic> favoriteListIds = box.read(FAVORITE_PRODUCT_BOX) ?? [];
    favoriteProduct = _dataProvider.products.where((product)=> favoriteListIds.contains(product.sId)).toList();
    notifyListeners();
  }

  ///Clear Favorite List
  clearFavoriteList(){
    box.remove(FAVORITE_PRODUCT_BOX);
    notifyListeners();
  }



}
