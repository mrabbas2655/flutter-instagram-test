import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/post.dart';
import '../widgets/post_item.dart';

class HomeScanner extends StatefulWidget {
  const HomeScanner({super.key});

  @override
  State<HomeScanner> createState() => _HomeScannerState();
}

class _HomeScannerState extends State<HomeScanner> {
  // لیست پست‌ها
  final List<Post> _posts = List.generate(
    10,
    (index) => Post(
      imageUrl: "assets/images/single_place_holder.jpg", // مسیر تصویر
      description: "پست شماره ${index + 1}",
      comments: [
        "این تگ بلاگ فوق‌العاده است!",
        "عاشق این پست شدم. تگ‌ها خیلی مفید هستند.",
      ],
      users: [
        "حسین احمدی",
        "مریم محسن‌زاده",
      ],
    ),
  );

  // متد برای تغییر وضعیت لایک
  void _toggleLike(Post post) {
    setState(() {
      post.isLiked = !post.isLiked;
    });
  }

  // متد برای تغییر وضعیت ذخیره
  void _toggleSave(Post post) {
    setState(() {
      post.isSaved = !post.isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {},
                child: const Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Instagram",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return PostItem(
            post: _posts[index],
            onLike: _toggleLike,
            onSave: _toggleSave,
          );
        },
      ),
    );
  }
}
