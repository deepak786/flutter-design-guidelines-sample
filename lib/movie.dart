class Movie {
  String title;
  String image;
  num rating;
  int releaseYear;
  List<String> genre;

  Movie({this.title, this.image, this.rating, this.releaseYear, this.genre});

  Movie.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    rating = json['rating'];
    releaseYear = json['releaseYear'];
    genre = json['genre'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['image'] = this.image;
    data['rating'] = this.rating;
    data['releaseYear'] = this.releaseYear;
    data['genre'] = this.genre;
    return data;
  }
}
