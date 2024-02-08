import 'package:flutter/material.dart';
import 'package:tmdb_movie/constants/appconstant.dart';

class ImageNetworkWidget extends StatelessWidget {
  const ImageNetworkWidget({super.key, required this.imageSrc, required this.height, required this.width, this.radius = 0.0});

  final String imageSrc;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
          '${AppConstant.urlImage780}$imageSrc',
          height: height,
          width: width,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return SizedBox(
              height: height,
              width: width,
              child: const Icon(Icons.broken_image_rounded,
              ),
            );
          }
      ),
    );
  }
}
