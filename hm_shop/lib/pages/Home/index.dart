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
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
          child: SizedBox(
        height: 10,
      )),
      HmMoreList(recommendList: _recommendList),
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

  // 热榜推荐
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );
  // 一站式推荐
  SpecialRecommendResult _oneStopResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  @override
  void initState() {
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getProductList();
    _getInVogueList();
    _getOneStopList();
    _getRecommendList();
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

  // 获取热榜推荐列表
  void _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  void _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

//获取推荐列表
  void _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: _getScrollChildern(),
    );
  }
}
