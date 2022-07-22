import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

class PostCard extends StatelessWidget {
  final String label;
  final String? urlPicture;
  final String content;
  final String footer;

  const PostCard({
    Key? key,
    required this.label,
    this.urlPicture,
    required this.content,
    required this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GbCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              urlPicture != null && urlPicture!.isNotEmpty
                  ? CircleAvatar(
                      foregroundImage: NetworkImage(urlPicture!),
                    )
                  : CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text(label.characters.first),
                    ),
              SpacerMedium(),
              GbLabel(label),
            ],
          ),
          SpacerMedium(),
          GbText(content),
          SpacerMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GbText(footer, style: const TextStyle(fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
