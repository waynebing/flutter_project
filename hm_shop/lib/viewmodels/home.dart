class BannerItem {
  String id;
  String imgUrl;
  BannerItem({required this.id, required this.imgUrl});
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    // 必须返回一个BannerItem对象
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

// 分类列表
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem>? children;
  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children,
  });
  // 扩展一个工厂函数 一般用factory来声明 一般用来创建实例对象
  factory CategoryItem.formJSON(Map<String, dynamic> json) {
    // 必须返回一个CategoryItem对象
    return CategoryItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      picture: json["picture"] ?? "",
      children: json["children"] == null
          ? null
          : (json["children"] as List)
              .map(
                (item) => CategoryItem.formJSON(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }
}

// 特惠推荐 - 商品项
class GoodsItem {
  String id;
  String name;
  String? desc;
  String price;
  String picture;
  int orderNum;
  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });
  factory GoodsItem.formJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      desc: json["desc"]?.toString(),
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
    );
  }
}

// 特惠推荐 - 商品分页信息
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;
  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });
  factory GoodsItems.formJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: int.tryParse(json["counts"]?.toString() ?? "0") ?? 0,
      pageSize: int.tryParse(json["pageSize"]?.toString() ?? "0") ?? 0,
      pages: int.tryParse(json["pages"]?.toString() ?? "0") ?? 0,
      page: int.tryParse(json["page"]?.toString() ?? "0") ?? 0,
      items: (json["items"] as List? ?? [])
          .map((item) => GoodsItem.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

// 特惠推荐 - 子类型
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;
  SubType({required this.id, required this.title, required this.goodsItems});
  factory SubType.formJSON(Map<String, dynamic> json) {
    return SubType(
      id: json["id"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      goodsItems: GoodsItems.formJSON(
        json["goodsItems"] as Map<String, dynamic>,
      ),
    );
  }
}

// 特惠推荐 - 结果
class SpecialRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;
  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });
  factory SpecialRecommendResult.formJSON(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json["id"]?.toString() ?? "",
      title: json["title"]?.toString() ?? "",
      subTypes: (json["subTypes"] as List? ?? [])
          .map((item) => SubType.formJSON(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
