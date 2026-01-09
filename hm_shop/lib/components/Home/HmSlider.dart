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
  Widget _getSlider() {
    //在flutter 获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width; //屏幕的宽度
    //返回轮播图插件
    return CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
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

  @override
  Widget build(BuildContext context) {
    return Stack(children: [_getSlider()]);

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
