import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;

   ShimmerWidget.rectangular(
      { this.width = double.infinity, required this.height})
      : this.shapeBorder= RoundedRectangleBorder();
  //  const ShimmerWidget.circular(
  //     { required this.width, required this.height,
  //       this.shapeBorder =  CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(255, 240, 240, 240),
      highlightColor: const Color.fromARGB(255, 232, 232, 232),

      child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(shape: shapeBorder,
            color: Colors.grey[300],)
      ),
    );
  }
}
