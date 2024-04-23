import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:gratitude_app/utils/size.dart';
import 'package:gratitude_app/utils/theme.dart';

class CustomListCard extends StatelessWidget {
  const CustomListCard({super.key, this.title, this.image});

  final String? title;
  final String? image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: secondaryColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title!,
                maxLines: 3,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: textColor,
                    ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                height: SizeConfig.screenHeight! * 0.12,
                imageUrl: image!,
                errorWidget: (context, str, obj) {
                  return Image.asset(
                    "images/gratitude.png",
                    color: primaryColor,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
