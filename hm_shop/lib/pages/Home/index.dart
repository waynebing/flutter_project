import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/HmCategory.dart';
import 'package:hm_shop/components/Home/HmHot.dart';
import 'package:hm_shop/components/Home/HmMoreList.dart';
import 'package:hm_shop/components/Home/HmSlider.dart';
import 'package:hm_shop/components/Home/HmSuggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 分类列表
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    // BannerItem(
    //   id: "1",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg",
    // ),
    // BannerItem(
    //   id: "2",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png",
    // ),
    // BannerItem(
    //   id: "3",
    //   imgUrl: "https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg",
    // ),
  ];
  //https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/1.jpg
  // https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/2.png
  // https://yjy-teach-oss.oss-cn-beijing.aliyuncs.com/meituan/3.jpg

  // 获取滚动容器的内容
  List<Widget> _getScrollChildern() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)), // 轮播图组件
      // 放置分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: HmCategory(categoryList: _categoryList),
      ), // 分类组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ), // 分类组件
      // SliverGrid SliverList只能纵向排列
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // ListView
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
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
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

  // 页码
  int _page = 1;
  bool _isLoading = false; // 当前正在加载状态
  bool _hasMore = true; // 是否还有下一页
  // 获取推荐列表

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }
  // initState > build => 下拉刷新组件 => 才可以操作它
  // Future.micoTask

  // 监听滚动到底部的事件
  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        // print("到底啦");
        // 加载下一页数据
        _getRecommendList();
      }
    });
  }

  Future<void> _getRecommendList() async {
    // 当已经有请求正在加载 或者已经没有下一页了 就放弃请求
    if (_isLoading || !_hasMore) {
      return;
    }

    _isLoading = true; // 占住位置
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoading = false; // 松开位置
    setState(() {});
    // 我要10条 你给10条 说明我要的你都给了 接着认为还有下一页
    // 我要10条 你给9条
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }
    _page++; // _page +=1;
  }

  // 获取热榜推荐列表
  Future<void> _getInVogueList() async {
    _inVogueResult = await getInVogueListAPI();
  }

  // 获取一站式推荐列表
  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListAPI();
  }

  // 获取特惠推荐列表
  Future<void> _getProductList() async {
    _specialRecommendResult = await getSpecialRecommendAPI();
  }

  // 获取轮播图列表
  Future<void> _getBannderList() async {
    _bannerList = await getBannerListAPI();
  }

  // 获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoading = false;
    _hasMore = true;
    await _getBannderList();
    await _getCategoryList();
    await _getProductList();
    await _getInVogueList();
    await _getOneStopList();
    await _getRecommendList();
    // 数据获取成功 刷新成功了
    ToastUtils.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();

  // GlobalKey是一个方法可以创建一个key绑定到Widget部件上 可以操作Widget部件
  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller, // 绑定控制器
          slivers: _getScrollChildern(),
        ),
      ),
    ); // sliver家族的内容
  }
}
// 动画组件
