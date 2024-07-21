import 'package:flutter/material.dart';
import 'package:news_app/pages/see_news_page.dart';

class NewsCard extends StatelessWidget {
  final String newsTitle;
  final String newsContent;
  final String newsImageURL;
  final String newsDate;

  const NewsCard(
      {super.key,
      required this.newsTitle,
      required this.newsDate,
      required this.newsContent,
      required this.newsImageURL,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SeeNewsPage(
              newsTitle: newsTitle,
              newsDate: newsDate,
              newsContent: newsContent,
              newsImageURL: newsImageURL);
        }));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 8, right: 8),
        child: Card(
          color: const Color.fromRGBO(255, 249, 196, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // news heading
              ListTile(
                title: Text(
                  newsTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: "Poppins-Bold"),
                ),
                subtitle: Text(
                  newsDate,
                  style: const TextStyle(
                    fontFamily: "Poppins-Regular",
                    color: Colors.black54,
                    fontSize: 10,
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // news image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  newsImageURL,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
