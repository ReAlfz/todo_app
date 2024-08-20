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
        centerTitle: true,
        title: const Text(
          'Todo Apps',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 30
          ),
        ),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hello!, \nWe meet again\ndont forget your task for today',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: CarouselSlider.builder(
                itemCount: ref.watch(listProvider).length,
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: min(size.width, size.height) - 80,
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

      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: FloatButton(code: true, index: 0),
      ),
    );
  }
}