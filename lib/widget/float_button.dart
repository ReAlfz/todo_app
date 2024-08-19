import 'package:flutter/material.dart';
import 'package:todo/screen/create_task.dart';

class FloatButton extends StatelessWidget {
  const FloatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'fab',
      onPressed: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const CreateTask();
            },

            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: animation.drive(
                    Tween(
                      begin: const Offset(0.0, 1.0), 
                      end: const Offset(0.0, 0.0),
                    ).chain(CurveTween(curve: Curves.easeInOut))
                ),
                child: child,
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      backgroundColor: Colors.lightBlue,
      child: const Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}