import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/utils/drawer.dart';
import 'package:news_app/utils/news_card.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/utils/news_category_button.dart';

class MyHomePage extends StatefulWidget {
  static String newsCategory = "all";
  String? category;
  int? selectedIndex;

  MyHomePage({super.key, category, selectedIndex}) {
    if (category != null) {
      newsCategory = category.toString().toLowerCase();
      _MyHomePageState._selectedIndex = selectedIndex;
    }
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static String _apiResp = "";
  static Map<String, dynamic>? _resp;
  static bool _isDataFetched = false;
  static int _selectedIndex = 0;

  static final _newsCategories = [
    "All",
    "Entertainment",
    "Sports",
    "Technology",
    "Startup",
    "Business",
    "Science",
    "Automobile",
    "Politics",
    "National",
    "World",
    "Hatke",
    "Miscellaneous",
  ];

  static final List<IconData> _iconsArr = [
    // "All",
    Icons.done_all_rounded,
    // "Entertainment",
    Icons.movie,
    // "Sports",
    Icons.sports_baseball_rounded,
    // "Technology",
    Icons.five_g_rounded,
    // "Startup",
    Icons.arrow_upward_rounded,
    // "Business",
    Icons.business_rounded,
    // "Science",
    Icons.science_rounded,
    // "Automobile",
    Icons.garage_rounded,
    // "Politics",
    Icons.people_alt_rounded,
    // "National",
    Icons.flag_circle_rounded,
    // "World",
    Icons.blur_circular_rounded,
    // "Hatke",
    Icons.thumbs_up_down_rounded,
    // "Miscellaneous",
    Icons.article_rounded
  ];

  Future<void> fetchNews() async {
    String url =
        "https://inshortsapi.vercel.app/news?category=${MyHomePage.newsCategory}";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    _apiResp = response.body;
    _resp = json.decode(_apiResp);
    _isDataFetched = true;
    setState(() {});
  }

  void callFirst() async {
    await fetchNews();
  }

  @override
  void initState() {
    super.initState();
    callFirst();
  }

  Widget _generateNews() {
    return _isDataFetched
        ? ListView.builder(
            itemCount: _resp!["data"].length,
            itemBuilder: (context, index) {
              String newsTitle = _resp!["data"][index]["title"];
              String newsDate = _resp!["data"][index]["date"];
              String newsContent = _resp!["data"][index]["content"];
              String newsImgURL = _resp!["data"][index]["imageUrl"];

              return NewsCard(
                newsTitle: newsTitle,
                newsDate: newsDate,
                newsContent: newsContent,
                newsImageURL: newsImgURL,
              );
            })
        : const Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Quick News by RB",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            // fontSize: 25,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 8),
              child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _newsCategories.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 14),
                          child: InkWell(
                              onTap: () {
                                MyHomePage.newsCategory =
                                    _newsCategories[index].toLowerCase();
                                _selectedIndex = index;
                                fetchNews();
                                setState(() {
                                  _isDataFetched = false;
                                });
                              },
                              child: NewsCategoryButton(
                                newsCategory: _newsCategories[index],
                                icon: _iconsArr[index],
                                selectedIndex: _selectedIndex,
                                currIndex: index,
                              )),
                        );
                      })),
            ),
            Center(
              child: SizedBox(
                height: 670,
                width: double.infinity,
                child: _generateNews(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
