/**
 *  Author:GasolZhang
 *  Date:2020-03-29
 */

import 'package:flutter/cupertino.dart';
import 'package:jingdong/cart/cart_goods_model.dart';

///
class CartStateProvider with ChangeNotifier {
  bool _editMode = false;

  bool get editMode => _editMode;

  bool _allSelected = false;

  bool get allSelected => _allSelected;

  List<CartGoodsModel> _selectModels = [];

  List<CartGoodsModel> get selectModels => _selectModels;

  void changeMode() {
    this._editMode = !_editMode;
    notifyListeners();
  }

  void addSelected(CartGoodsModel model) {
    if (model != null) {
      _selectModels.add(model);
      notifyListeners();
    }
  }

  void removeSelected(CartGoodsModel model) {
    if (_selectModels.contains(model)) {
      _selectModels.remove(model);
      notifyListeners();
    }
  }

  void changeAllSelected(bool allSelected) {
    this._allSelected = allSelected;
    notifyListeners();
  }
}
