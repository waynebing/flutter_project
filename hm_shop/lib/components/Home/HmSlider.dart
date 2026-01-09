import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;

  HmSlider({Key? key, required this.bannerList}) : super(key: key);

  @override
  _HmSliderState createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  CarouselSliderController _controller = CarouselSliderController(); //控制轮播图的控制器
  int _currentIndex = 0; //当前激活索引
  Widget _getSlider() {
    //在flutter 获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width; //屏幕的宽度
    //返回轮播图插件
    return CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          onPageChanged: (int index, reason) {
            _currentIndex = index;
            setState(() {});
          },
          autoPlayInterval: Duration(seconds: 3),
        ),
        items: List.generate(
            widget.bannerList.length,
            (index) => Image.network(
                  widget.bannerList[index].imgUrl,
                  fit: BoxFit.cover,
                  width: screenWidth,
                )));
  }

  Widget _getSearch() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 返回指示灯导航部件
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 主轴居中
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.jumpToPage(index);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 6,
                width: index == _currentIndex ? 40 : 20,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);

    /* Container(
      height: 300,
      alignment: Alignment.center,
      color: Colors.blue,
      child: Text(
        "轮播图",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    ); */
  }
}
