import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

import '../../../shared/utils/formart_date.dart';
import '../../domain/entities/post.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GbCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              post.userUrlPicture != null && post.userUrlPicture!.isNotEmpty
                  ? CircleAvatar(
                      foregroundImage: NetworkImage(post.userUrlPicture!),
                    )
                  : CircleAvatar(
                      backgroundColor: primaryColor,
                      child: Text(post.userName.characters.first),
                    ),
              SpacerMedium(),
              GbLabel(post.userName),
            ],
          ),
          SpacerMedium(),
          GbText(post.message),
          SpacerMedium(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GbText(
                formatDate(post.createdDate),
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
