import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../screens/ comment_page.dart';

class PostItem extends StatelessWidget {
  final Post post;
  final Function(Post) onLike;
  final Function(Post) onSave;

  const PostItem(
      {super.key,
      required this.post,
      required this.onLike,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(post.imageUrl),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      post.isLiked
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: post.isLiked ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      onLike(post); // تغییر وضعیت لایک
                    },
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.chat_bubble),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentPage(post: post),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.share),
                    onPressed: () {},
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  post.isSaved
                      ? CupertinoIcons.bookmark_fill
                      : CupertinoIcons.bookmark,
                ),
                onPressed: () {
                  onSave(post); // تغییر وضعیت ذخیره
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
