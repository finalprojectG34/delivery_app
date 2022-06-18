import 'package:delivery_app/src/app.dart';
import 'package:delivery_app/src/screens/items/item_list_ctx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../components/error_page.dart';
import 'item_mini_view/item_mini_detail.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  static const _pageSize = 20;
  final ItemListController itemListCtx = Get.find();

  final PagingController<int, Item> _pagingController =
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
      final newItems = await itemListCtx.getItems(pageKey, _pageSize);
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
        appBar: AppBar(title: const Text("Flash Sales")),
        body: GetX<ItemListController>(
          builder: (ctx) {
            if (ctx.isLoading.isTrue) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (ctx.itemList.value != null) {
              if (ctx.itemList.value!.isEmpty) {
                return const Center(
                  child: Text("No item"),
                );
              }
              return PagedGridView<int, Item>(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .65,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5),
                pagingController: _pagingController,
                showNewPageProgressIndicatorAsGridChild: false,
                builderDelegate: PagedChildBuilderDelegate<Item>(
                  itemBuilder: (context, item, index) => ItemMiniDetail(
                    item: item,
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
