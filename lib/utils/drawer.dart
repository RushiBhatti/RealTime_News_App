import 'package:flutter/material.dart';
import 'package:news_app/pages/home_page.dart';

class MyDrawer extends StatelessWidget {
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

  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      surfaceTintColor: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
                child: Column(children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: Text(
                              'News',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                letterSpacing: 2,
                                fontFamily: "Poppins-SemiBold",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Row(
                          children: [
                            Text(
                              'Categories',
                              style: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 25,
                                letterSpacing: 2,
                                fontFamily: "Poppins-SemiBold",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
              ),
              SizedBox(
                height: 700,
                child: ListView.builder(
                    itemCount: _newsCategories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return MyHomePage(
                              category: _newsCategories[index],
                              selectedIndex: index,
                            );
                          }));
                        },
                        child: ListTile(
                          leading: Icon(
                            _iconsArr[index],
                            color: Colors.white,
                          ),
                          title: Text(
                            _newsCategories[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
