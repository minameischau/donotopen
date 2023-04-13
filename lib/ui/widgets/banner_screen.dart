import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:panow/ui/control_screen.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  State<BannerScreen> createState() => _BannerScreenState();

}

class _BannerScreenState extends State<BannerScreen> {
  final List<String> imageList = [
    'https://res.cloudinary.com/dvbzja2gq/image/upload/w_1000,ar_16:9,c_fill,g_auto,e_sharpen/v1681370642/techStore/banner/keyboard_banner_yrnsar.jpg',
    'https://res.cloudinary.com/dvbzja2gq/image/upload/w_1000,ar_16:9,c_fill,g_auto,e_sharpen/v1681370642/techStore/banner/mouse_banner_iawgsd.jpg',
    'https://res.cloudinary.com/dvbzja2gq/image/upload/w_1000,ar_16:9,c_fill,g_auto,e_sharpen/v1681370643/techStore/banner/headphone_banner_vri6cr.png',
  ];

  final List<String> captions = [
    'Keyboard',
    'Mouse',
    'Headphone',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bannerHeight = screenHeight * 0.25;
    return Column(
      children: [
        Center(
          child: CarouselSlider(
            options: CarouselOptions(
              height: bannerHeight,
              enlargeCenterPage: true,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: imageList.map((imageUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.white54,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            captions[_currentIndex],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.deepOrange),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: bannerHeight * 0.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageList.map((imageUrl) {
            int index = imageList.indexOf(imageUrl);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == index ? Colors.deepOrange : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
