import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScanner extends StatefulWidget {
  const HomeScanner({super.key});

  @override
  State<HomeScanner> createState() => _HomeScannerState();
}

class _HomeScannerState extends State<HomeScanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isLiked = false; // وضعیت لایک
  bool _isSaved = false; // وضعیت ذخیره (Bookmark)

  // لیست پست‌ها
  final List<String> _posts = List.generate(
    10,
    (index) => "پست شماره ${index + 1}",
  );

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    if (!_isLiked) {
      _animationController.forward();
    }
    setState(() {
      _isLiked = !_isLiked;
    });
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
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
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/single_place_holder.jpg"),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) {
                            return IconButton(
                              icon: Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Icon(
                                  _isLiked
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color: _isLiked ? Colors.red : Colors.black,
                                ),
                              ),
                              onPressed: _toggleLike,
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(CupertinoIcons.chat_bubble),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentPage(),
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
                        _isSaved
                            ? CupertinoIcons.bookmark_fill
                            : CupertinoIcons.bookmark,
                        color: _isSaved ? Colors.black : Colors.black,
                      ),
                      onPressed: _toggleSave,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _commentController = TextEditingController();
  List<String> _comments = [
    "این تگ بلاگ فوق‌العاده است!",
    "عاشق این پست شدم. تگ‌ها خیلی مفید هستند.",
    "با تگ‌ها راحت‌تر میشه موضوعات مختلف رو پیدا کرد.",
    "تگ بلاگ‌ها به جستجو کمک می‌کنن، عالیه!",
    "خیلی جالب بود! همیشه به تگ‌ها توجه کنید.",
    "این تگ‌ها اطلاعات زیادی رو به نمایش می‌ذارن.",
    "به نظر من تگ‌ها باعث رشد محتوا می‌شن.",
    "واقعا، تگ‌ها رو نباید فراموش کرد.",
    "محتوای تگ‌ها خیلی جذاب و آموزنده است.",
    "تگ‌ها به راحتی محتوا رو دسته‌بندی می‌کنن.",
  ]; // لیستی از کامنت‌ها
  List<String> _users = [
    "حسین احمدی",
    "مریم محسن‌زاده",
    "علی رحمانی",
    "نرگس عبدی",
    "سارا صادقی",
    "مهسا کاظمی",
    "آرش طالبی",
    "کاوه آقایی",
    "پریسا جلالی",
    "محمدرضا شفیعی",
  ]; // لیست نام کاربران کامنت‌گذار

  void _addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        _comments.add(_commentController.text);
        _users.add("کاربر جدید");
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("کامنت‌ها"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.xmark),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _users[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            _comments[index],
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(CupertinoIcons.person),
                    radius: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: "کامنتی بنویسید...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(CupertinoIcons.arrow_up_circle_fill),
                    onPressed: _addComment,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
