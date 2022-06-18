import 'package:delivery_app/src/models/shop.dart';
import 'package:delivery_app/src/screens/components/shop_item.dart';
import 'package:delivery_app/src/screens/shops_list/shops_list_ctx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../components/error_page.dart';

class ShopsList extends StatefulWidget {
  const ShopsList({Key? key}) : super(key: key);

  @override
  _ShopsListState createState() => _ShopsListState();
}

class _ShopsListState extends State<ShopsList> {
  static const _pageSize = 20;
  final ShopsListController shopsListCtx = Get.find();

  final PagingController<int, Shop> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    _fetchPage(0);
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await shopsListCtx.getShops(pageKey, _pageSize);
      if (newItems != null) {
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + newItems.length;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Shops")),
        body: GetX<ShopsListController>(
          builder: (ctx) {
            if (ctx.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (ctx.shopsList.value != null) {
              if (ctx.shopsList.value!.isEmpty) {
                return const Center(
                  child: Text("No shop"),
                );
              }
              return PagedGridView<int, Shop>(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 2),
                ),
                pagingController: _pagingController,
                showNewPageProgressIndicatorAsGridChild: false,
                builderDelegate: PagedChildBuilderDelegate<Shop>(
                  itemBuilder: (context, item, index) => ShopItem(
                    shop: item,
                  ),
                ),
              );
            }
            return errorPage(onTryAgain: () {
              _fetchPage(0);
            });
          },
        ));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
