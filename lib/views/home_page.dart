import 'package:flutter/material.dart';
import 'package:game_search/models/game.dart';
import 'package:game_search/services/api.dart';
import 'package:game_search/utils/appbar_gradient.dart';
import 'package:game_search/utils/background.dart';
import 'package:game_search/views/detail_page.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Icon _searchIcon = const Icon(Icons.search);
  Widget _searchBar = const Text("Home");
  final String _title = "Home";
  final _searchController = TextEditingController();
  late List<Game> _games;
  bool _isLoading = true;
  String _hover = "";

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch({String query = ""}) async {
    setState(() {
      _isLoading = true;
    });

    List? list = await Api().fetch('game', queryParams: {"title": query});
    setState(() {
      if(list == null) {
        _games = [];
      }
      else {
        _games = list.map((item) => Game.fromJson(item)).toList();
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.round();

    return Scaffold(
      appBar: AppBar(
        title: _searchBar,
        flexibleSpace: appBarGradient(),
        leading: _searchIcon.icon == Icons.search ? null : IconButton(
          onPressed: () => _fetch(query: _searchController.text),
          icon: const Icon(Icons.search),
        ),
        automaticallyImplyLeading: false,
        actions: [
          if(_searchIcon.icon == Icons.search)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                _fetch();
                _searchController.clear();
              },
            ),
          IconButton(
            icon: _searchIcon,
            onPressed: _searchAction,
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            buildBackgroundImage(),
            _buildBodyWidget(width),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyWidget(int width) {
    return _isLoading ? const Center(child: CircularProgressIndicator()) : _games.length == 0
    ? Center(
      child: Card(
        color: Colors.black.withOpacity(0.5),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        margin: const EdgeInsets.all(8.0),
        elevation: 5.0,
        shadowColor: Colors.black.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Game not found",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      )
    )
    : GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (width / 250).round(),
        mainAxisExtent: 200.0,
      ),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemCount: _games.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildGameCard(context, _games[index]);
      },
    );
  }

  Widget _buildGameCard(BuildContext context, Game game) {
    return Card(
      color: Colors.black.withOpacity(0.5),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.2),
      child: InkWell(
        onHover: (value) => setState(() => _hover = value ? game.title : ""),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailPage(game: game)),
          );
        },
        child: Stack(
          children: [
            Opacity(
              opacity: _hover == game.title ? 0.75 : 1.0,
              child: Image.network(
                game.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 2.0,
                        ),
                        child: Text(
                          game.title,
                          style: _hover == game.title
                            ? Theme.of(context).textTheme.bodyText1
                            : Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchText() {
    return TextField(
      controller: _searchController,
      onSubmitted: (value) => _fetch(query: value),
      style: GoogleFonts.notoSans(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Enter game title',
        hintStyle: GoogleFonts.notoSans(color: Colors.white),
        border: InputBorder.none,
      ),
    );
  }

  void _searchAction() {
    setState(() {
      if(_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.cancel);
        _searchBar = _buildSearchText();
      }
      else {
        _searchIcon = const Icon(Icons.search);
        _searchBar = Text(_title);
      }
    });
  }
}
