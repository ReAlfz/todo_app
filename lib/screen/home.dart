import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/screen/detail.dart';
import 'package:todo/state/provider.dart';
import 'package:todo/widget/float_button.dart';
import 'package:todo/widget/info_carousel.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Text('loading')
            ),

            Flexible(
              flex: 9,
              fit: FlexFit.tight,
              child: CarouselSlider.builder(
                itemCount: ref.watch(listProvider).length,
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: min(size.width, size.height) - 90,
                  viewportFraction: size.height >= size.width ? 0.8 : 0.5,
                  initialPage: 0,
                  reverse: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return GestureDetector(
                    child: InfoCarousel(ref: ref, index: index, realIndex: realIndex),
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return DetailScreen(mIndex: index, realIndex: realIndex);
                          },
                          transitionDuration: const Duration(milliseconds: 600),
                          reverseTransitionDuration: const Duration(milliseconds: 600),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const FloatButton(),
    );
  }
}