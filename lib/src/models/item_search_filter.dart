class ItemSearchFilter {
  String? searchTerm;
  double minPrice;
  double maxPrice;
  List<FilterAttributes>? attributes;
  ReqPagInfo? reqPagInfo;

  ItemSearchFilter(
      {this.searchTerm,
      this.minPrice = 0,
      this.maxPrice = 3000,
      this.attributes,
      this.reqPagInfo});
}

class FilterAttributes {
  String? name;
  List<String>? values;

  FilterAttributes({this.name, this.values});
}

class ReqPagInfo {
  int pageNo;
  int limit;

  ReqPagInfo({this.pageNo = 1, this.limit = 20});
}
