import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget customListTile(
    {required String title,
    required String singer,
    required String cover,
    onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Row(children: [
        Container(
          height: 80,
          width: 80,
          child: CachedNetworkImage(
            imageUrl: cover,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            SizedBox(height: 5),
            Text(singer, style: TextStyle(color: Colors.grey, fontSize: 16))
          ],
        ),
      ]),
    ),
  );
}
