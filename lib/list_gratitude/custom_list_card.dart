import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:gratitude_app/utils/size.dart';
import 'package:gratitude_app/utils/theme.dart';

class CustomListCard extends StatelessWidget {
  const CustomListCard({super.key});

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
                "I am so sorry and gratefull I am so sorry and gratefull that i had a productive white board session with Sijasd jfdlskjflk",
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
                imageUrl:
                    "https://img.freepik.com/free-vector/gradient-orange-violet-abstract-background_23-2148453876.jpg?w=1380&t=st=1713165456~exp=1713166056~hmac=ad5b8e78ab87778ae8831e71f07df4402e7bd63ce66ae6687d93411afb367469",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
