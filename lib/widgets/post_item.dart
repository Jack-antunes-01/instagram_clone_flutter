import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';

import '../constants/story_json.dart';
import '../theme/colors.dart';

class PostItem extends StatefulWidget {
  final VoidCallback callback;

  final String name;
  final String profileImg;
  final String postImg;
  final String caption;
  final bool isLoved;
  final String commentCount;
  final String likedBy;
  final String timeAgo;

  const PostItem({
    Key? key,
    required this.name,
    required this.profileImg,
    required this.postImg,
    required this.caption,
    required this.isLoved,
    required this.commentCount,
    required this.likedBy,
    required this.timeAgo,
    required this.callback,
  }) : super(key: key);

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  bool liked = false;

  void likeFn() async {
    widget.callback();
    setState(() {
      liked = true;
    });

    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        liked = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(widget.profileImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const Icon(
                LineIcons.horizontalEllipsis,
                color: white,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onDoubleTap: () => likeFn(),
          child: Stack(
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.postImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                transform: Transform.translate(
                  offset: Offset((size.width / 2) - 15, liked ? 175 : 275),
                ).transform,
                child: SvgPicture.asset(
                  widget.isLoved
                      ? "assets/images/loved_icon.svg"
                      : "assets/images/love_icon.svg",
                  width: liked ? 50 : 0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => likeFn(),
                    child: SvgPicture.asset(
                      widget.isLoved
                          ? "assets/images/loved_icon.svg"
                          : "assets/images/love_icon.svg",
                      width: 27,
                    ),
                  ),
                  const SizedBox(width: 20),
                  SvgPicture.asset(
                    "assets/images/comment_icon.svg",
                    width: 27,
                  ),
                  const SizedBox(width: 20),
                  SvgPicture.asset(
                    "assets/images/message_icon.svg",
                    width: 27,
                  ),
                ],
              ),
              SvgPicture.asset(
                "assets/images/save_icon.svg",
                width: 27,
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Liked by ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: widget.likedBy,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const TextSpan(
                  text: " and ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextSpan(
                  text: "other",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: widget.caption,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
            left: 15,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "View all ",
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: widget.commentCount,
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: " comments",
                  style: TextStyle(
                    color: white.withOpacity(0.5),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
            left: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(profile),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    "Add a comment",
                    style: TextStyle(
                      color: white.withOpacity(0.5),
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "😍",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "😂",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.add_circle,
                    color: white.withOpacity(0.5),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Text(
            widget.timeAgo,
            style: TextStyle(
              color: white.withOpacity(0.5),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
