import 'package:flutter/material.dart';
import 'package:game_search/models/game.dart';
import 'package:game_search/utils/appbar_gradient.dart';
import 'package:game_search/utils/background.dart';

class DetailPage extends StatelessWidget {
  final Game game;
  final _scrollController = ScrollController();

  DetailPage({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          game.title,
          overflow: TextOverflow.ellipsis,
        ),
        flexibleSpace: appBarGradient(),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            buildBackgroundImage(),
            _buildBodyWidget(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: [
        Card(
          color: Colors.black.withOpacity(0.5),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.all(8.0),
          elevation: 5.0,
          shadowColor: Colors.black.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(
                  game.image,
                  fit: BoxFit.cover,
                ),
                _buildText(context, "ชื่อเกม", game.title),
                _buildText(context, "แนวเกม", game.genre),
                _buildText(context, "แพลตฟอร์ม", game.platform),
                _buildText(context, "วันที่วางจำหน่าย", game.date),
                _buildText(context, "เนื้อเรื่องย่อ", game.synopsis),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildText(BuildContext context, String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const Divider(height: 10.0, color: Colors.white, thickness: 1.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }
}
