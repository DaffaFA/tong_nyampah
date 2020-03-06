import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tongnyampah/models/Gift.dart';
import 'package:tongnyampah/models/Slider.dart';
import 'package:tongnyampah/widgets/gift_card.dart';
import 'package:tongnyampah/widgets/item_container.dart';
import 'package:tongnyampah/widgets/navbar.dart';

class ShopMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Navbar(),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: CarouselSlider(
                height: MediaQuery.of(context).size.height * 0.28,
                enableInfiniteScroll: false,
                autoPlay: false,
                items: SliderItem.fetchAllSliderItem().map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height,
                            margin: EdgeInsets.symmetric(horizontal: 7.0),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                              color: Colors.white54,
                              image: DecorationImage(
                                  image: NetworkImage(item.image),
                                  fit: BoxFit.cover,
                                  repeat: ImageRepeat.noRepeat),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                constraints:
                                    BoxConstraints.expand(height: 65.0),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item.name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          shadows: <Shadow>[
                                            Shadow(
                                                color: Colors.black,
                                                offset: Offset(0.0, 0.8),
                                                blurRadius: 16.0),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          item.description,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }).toList(),
              ),
            ),
            Container(
              child: ItemContainer(
                margin: EdgeInsets.only(top: 40.0, bottom: 20.0),
                children: Gift.getAllGift()
                    .map((gift) => GiftCard(
                          margin: EdgeInsets.only(left: 20.0),
                          image: gift.image,
                          title: gift.name,
                          point: gift.point,
                        ))
                    .toList(),
              ),
            ),
            Container(
              child: ItemContainer(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                children: Gift.getAllGift()
                    .map((gift) => GiftCard(
                          margin: EdgeInsets.only(left: 20.0),
                          image: gift.image,
                          title: gift.name,
                          point: gift.point,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
