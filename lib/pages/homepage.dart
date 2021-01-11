import 'package:flutter/material.dart';
import 'package:news_app_restapi/models/newsInfo.dart';
import 'package:news_app_restapi/services/api_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<NewsModel> _newsmodel;

  @override
  void initState() {
    _newsmodel = ApiManager().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('News APP')),
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newsmodel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.articles.length,
                  itemBuilder: (context, index) {
                    var article = snapshot.data.articles[index];
                    return Container(
                      margin: EdgeInsets.all(8),
                      height: 100,
                      child: Row(
                        children: [
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                article.urlToImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 16,),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(article.title,
                                    overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold
                                ),),
                                Text(
                                  article.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 200),
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text('Loading')
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
