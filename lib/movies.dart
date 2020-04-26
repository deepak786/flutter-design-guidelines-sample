import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:http/http.dart' as http;

import 'dimens.dart';
import 'list_item_movie.dart';
import 'movie.dart';

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movies",
          style: TextStyle(
            fontSize: Dimens.fontSize,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white38,
      body: ListView(
        children: <Widget>[
          FutureBuilder<List<Movie>>(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // display the movies list
                return displayMovies(snapshot.data);
              } else if (snapshot.hasError) {
                // display the error text
                return Container(
                  child: Center(
                    child: Text(
                      snapshot.error.toString(),
                      style: TextStyle(
                        fontSize: Dimens.fontSize,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }

              // default display the loader
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
            initialData: null,
            future: fetchMoviesList(),
          ),
        ],
      ),
    );
  }

  // fetch the list of movies from server
  Future<List<Movie>> fetchMoviesList() async {
    final response =
        await http.get("https://api.androidhive.info/json/movies.json");
    if (response.statusCode == 200) {
      final body = response.body;
      return new List<Movie>.from(
          json.decode(body).map((x) => Movie.fromJson(x)));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movies');
    }
  }

  // display the movie list
  Widget displayMovies(List<Movie> movies) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double appBarHeight = kToolbarHeight;
    final double paddingTop = mediaQueryData.padding.top;
    final double paddingBottom = mediaQueryData.padding.bottom;
    final double heightScreen = mediaQueryData.size.height -
        paddingBottom -
        paddingTop -
        appBarHeight +
        (Device.get().isTablet ? 300 : -100 /** my factor **/);

    return GridView.count(
      crossAxisCount: Device.get().isTablet ? 2 : 1,
      physics: ScrollPhysics(),
      padding: EdgeInsets.all(Dimens.movieCardMargin),
      crossAxisSpacing: Dimens.movieCardMargin,
      mainAxisSpacing: Dimens.movieCardMargin,
      // to disable GridView's scrolling
      shrinkWrap: true,
      childAspectRatio: widthScreen / heightScreen,
      children: List.generate(movies.length ?? 0, (index) {
        return MovieItem(movies[index]);
      }),
    );
  }
}
