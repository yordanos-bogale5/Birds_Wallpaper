import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    this.url,
    required this.radius,
    this.onTap,
  });

  const Avatar.small({
    super.key,
    this.url,
    this.onTap,
  }) : radius = 18;

  const Avatar.medium({
    super.key,
    this.url,
    this.onTap,
  }) : radius = 24;

  const Avatar.large({
    super.key,
    this.url,
    this.onTap,
  }) : radius = 34;

  final double radius;
  final String? url;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _avatar(context),
    );
  }

  Widget _avatar(BuildContext context) {
    if (url != null) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(url!),
        backgroundColor: Theme.of(context).cardColor,
      );
    } else {
      return CircleAvatar(
        radius: radius,
        backgroundColor: Theme.of(context).cardColor,
        child: Center(
          child: Text(
            '?',
            style: TextStyle(fontSize: radius),
          ),
        ),
      );
    }
  }
}
