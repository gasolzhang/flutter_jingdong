import 'package:cached_network_image/cached_network_image.dart';
/**
 *  Author:GasolZhang
 *  Date:2020-03-25
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:jingdong/res.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

///
class GalleryPage extends StatefulWidget {
  GalleryPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageState();
  }
}

class _PageState extends State<GalleryPage> {
  PageController controller;
  List<String> images;
  int initalIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    if (images == null) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context).settings.arguments;
      images = arguments['images'];
      initalIndex = arguments['initalIndex'];
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Swiper(
              index: initalIndex,
              loop: false,
              itemCount: images?.length,
              pagination: SwiperPagination(
                  builder: DotSwiperPaginationBuilder(
                      size: 5, activeSize: 5, space: 3)),
              itemBuilder: (context, index) {
                return PhotoView(
                  loadingBuilder: (context, event) {
                    return Container(
                        color: Colors.black,
                        child:
                            Center(child: Image.asset(Res.image_placeholder)));
                  },
                  imageProvider: CachedNetworkImageProvider(images[index]),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        body: Container(
      child: PhotoViewGallery.builder(
        itemCount: images?.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(images[index]),
            initialScale: PhotoViewComputedScale.contained * 0.99,
            heroAttributes: PhotoViewHeroAttributes(tag: index),
          );
        },
        loadingBuilder: (context, event) {
          return LoadingFlipping.circle();
        },
        loadFailedChild: Image.asset(Res.network_error),
        pageController: controller,
        onPageChanged: (index) {},
      ),
    ));
  }
}
