/**
 *  Author:GasolZhang
 *  Date:2020-03-17
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jingdong/constant/constant.dart';
import 'package:jingdong/db/search_history_entity.dart';
import 'package:jingdong/mvp/base_view.dart';
import 'package:jingdong/router.dart';
import 'package:jingdong/search/search_presenter.dart';
import 'package:jingdong/widget/true_search_app_bar.dart';

///
class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchState();
  }
}

class SearchState extends BaseState<SearchPage, SearchPresenter> {
  List<String> _historys;

  @override
  void initState() {
    super.initState();
    showState = ShowState.NORMAL;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TrueSearchAppBar(searchCallback: (content) {
        Navigator.pushNamed(context, ROUTER_PRODUCT_LIST,
            arguments: {'key_word': content});
      }),
      body: Column(children: <Widget>[getHistoryTitle(), getHistoryContent()]),
    );
  }

  Widget getHistoryTitle() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Stack(children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Text('搜索历史',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold)),
        ),
        Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                icon: Icon(Icons.delete, size: 20, color: Colors.grey),
                onPressed: () async {
                  await presenter.clearSearchHistory();
                  tryShowNormal();
                }))
      ]),
    );
  }

  Widget getHistoryContent() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: StreamBuilder<List<SearchHistoryEntity>>(
          stream: presenter.loadHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _historys = snapshot.data.map((m) {
                return m.keyWord;
              }).toList();
              return Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(_historys?.length ?? 0, (index) {
                    return getHistoryItem(_historys[index]);
                  }));
            }
            return Text('');
          }),
    );
  }

  Widget getHistoryItem(String name) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ROUTER_PRODUCT_LIST,
            arguments: {'key_word': name});
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
        child: Text(name),
      ),
    );
  }

  @override
  SearchPresenter newPresenter() {
    return SearchPresenter();
  }
}
