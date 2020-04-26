import 'package:flutter/material.dart';
import 'package:flutter_guidelines/dimens.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'movie.dart';

class MovieItem extends StatefulWidget {
  final Movie movie;

  MovieItem(this.movie);

  @override
  _MovieItemState createState() => _MovieItemState();
}

class _MovieItemState extends State<MovieItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // image
          Expanded(
            child: FadeInImage.assetNetwork(
              placeholder: "images/loader_gif.gif",
              image: widget.movie.image,
              width: double.infinity,
              fit: BoxFit.cover,
              imageScale: 0.6,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(Dimens.movieContentPadding),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // rating
                RatingBarIndicator(
                  rating: widget.movie.rating.toDouble(),
                  direction: Axis.horizontal,
                  itemCount: 10,
                  itemSize: Dimens.movieRatingStarSize,
                  unratedColor: Colors.amber.withAlpha(50),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),

                SizedBox(
                  height: 5,
                ),

                // title
                Text(
                  widget.movie.title,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: Dimens.movieFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // genre
                Wrap(
                  children: widget.movie.genre
                      .map(
                        (chip) => Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Chip(
                              label: Text(
                            chip,
                            style: TextStyle(
                              fontSize: Dimens.movieGenreFontSize,
                            ),
                          )),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
