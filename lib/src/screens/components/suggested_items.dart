import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SuggestedItems extends StatefulWidget {
  const SuggestedItems({Key? key}) : super(key: key);

  @override
  State<SuggestedItems> createState() => _SuggestedItemsState();
}

class _SuggestedItemsState extends State<SuggestedItems> {
  int _current = 0;
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        CarouselSlider(
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.black26),
                  child: Container(
                    // height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.9), BlendMode.dstATop),
                          image: const NetworkImage(
                              "https://fdn.gsmarena.com/imgroot/reviews/20/apple-iphone-12-pro-max/lifestyle/-1200w5/gsmarena_008.jpg"),
                          onError: (e, s) {}),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        // Text(
                        //   'Super flash sale',
                        //   maxLines: 1,
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       color: Colors.white,
                        //       fontSize: 26),
                        // ),
                        SizedBox(
                          height: 10.0,
                        ),
                        // Text(
                        //   "50% off",
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 26,
                        //       color: Colors.white),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(
                () {
                  _current = index;
                },
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3, 4, 5].asMap().entries.map(
            (entry) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
