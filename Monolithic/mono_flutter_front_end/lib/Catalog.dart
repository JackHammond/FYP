class Catalog {
  int id;
  String title;
  String url;

  Catalog(int id, String title, String url) {
    this.id = id;
    this.title = title;
    this.url = url;
  }

  Catalog.fromJson(Map json)
      : id = json['id'],
        title = json['title'],
        url = json['url'];

  Map toJson() {
    return {'id': id, 'name': title, 'email': url};
  }
}