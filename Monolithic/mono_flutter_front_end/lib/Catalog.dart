// class Catalog {
//   final int id;
//   final String title;
//   final String department;
//   final String color;
//   final String price;

//   Catalog({this.department, this.id, this.title, this.color, this.price});

//   factory Catalog.fromJson(Map<String, dynamic> json) {
//     return Catalog(
//       department: json['department'] as String ?? 'department is null',
//       id: json['id'] as int ?? 'id is null',
//       title: json['name'] as String ?? 'name is null',
//       color: json['color'] as String ?? 'color is null',
//       price: json['price'] as String ?? 'price is null',
//     );
//   }
// }
