import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/services/api_manager.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<NewsModel> _newModel;
  @override
  void initState() {
    _newModel = API_Manger().getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News App"),
      ),
      body: Container(
        child: FutureBuilder<NewsModel>(
          future: _newModel,
          builder:(context, snapshot){
            if(snapshot.hasData){
              return  ListView.builder(
                itemCount: snapshot.data.articles.length,
                itemBuilder: (context, index){
                  var article =  snapshot.data.articles[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      color: Colors.black12,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                      child: Image.network(article.urlToImage)),
                                )),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(article.title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                  Text(article.description, overflow: TextOverflow.ellipsis,maxLines: 2,),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }else{
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
