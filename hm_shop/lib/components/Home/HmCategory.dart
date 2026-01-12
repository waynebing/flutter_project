import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  HmCategory({Key? key, required this.categoryList}) : super(key: key);

  @override
  _HmCategoryState createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.categoryList.length,
          itemBuilder: (BuildContext context, int index) {
            final CategoryItem categoryItem = widget.categoryList[index];
            return Container(
              width: 80,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 232, 234),
                  borderRadius: BorderRadius.circular(40)),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      categoryItem.picture,
                      width: 40,
                      height: 40,
                    ),
                    Text(
                      '${categoryItem.name}',
                      style: TextStyle(color: Colors.black),
                    )
                  ]),
            );
          }),
    );
  }
}
