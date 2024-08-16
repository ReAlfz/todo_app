import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/state/carousel_function.dart';

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
              flex: 8,
              fit: FlexFit.tight,
              child: CarouselSlider(
                items: ref.watch(carouselListProvider.notifier).getCard(context),
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  height: min(size.width, size.height) - 115,
                  viewportFraction: size.height >= size.width ? 0.8 : 0.5,
                  initialPage: 0,
                  reverse: false,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),

            Flexible(
              flex: 1,
              fit: FlexFit.tight,
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}