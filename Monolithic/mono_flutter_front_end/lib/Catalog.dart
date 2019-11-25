class Catalog {
  int id;
  String name;
  String url;
  String department;
  String color;
  String price;

  Catalog(int id, String name, String url,String department,String color,String price) {
    this.id = id;
    this.name = name;
    this.url = url;
    this.department = department;
    this.color = color;
    this.price = price;
  }

  Catalog.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        url = json['url'],
        department  = json['department'],
        price  = json['price'],
        color  = json['color'];

  Map toJson() {
    return {'id': id, 'name': name, 'url': url, 'department': department, 'price':price, 'color':color};
  }
}