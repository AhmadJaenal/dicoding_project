import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  const CustomCacheImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (_, __) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}
