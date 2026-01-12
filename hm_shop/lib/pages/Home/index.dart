import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    /* BannerItem(
        id: "1",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg"),
    BannerItem(
        id: "2",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/4.jpg"),
    BannerItem(
        id: "3",
        imgUrl:
            "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg"), */
  ];

  List<Widget> _getScrollChildern() {
    return [
      SliverToBoxAdapter(
          child: HmSlider(
        bannerList: _bannerList,
      )),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 10,
      )),
      SliverToBoxAdapter(
        child: HmCategory(categoryList: _categoryList),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 10,
      )),
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 10,
      )),
      SliverToBoxAdapter(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(child: HmHot()),
            SizedBox(width: 10),
            Expanded(child: HmHot()),
          ],
        ),
      )),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 10,
      )),
      HmMoreList(),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 10,
      )),
    ];
  }

  // 特惠推荐
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getProductList();
  }

  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  //获取特惠推荐列表
  void _getProductList() async {
    _specialRecommendResult = await getSpecialRecommendAPI();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildern(),
    );
  }
}
