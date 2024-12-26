class Coffee {
  String? name;
  String? image;
  String? description;
  List<String>? sizes;
  List<MoreOptions>? moreOptions;
  double? price;

  Coffee(
      {this.name,
      this.image,
      this.description,
      this.sizes,
      this.moreOptions,
      this.price});

  Coffee.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    description = json['description'];
    sizes = json['sizes'].cast<String>();
    if (json['moreOptions'] != null) {
      moreOptions = <MoreOptions>[];
      json['moreOptions'].forEach((v) {
        moreOptions!.add(new MoreOptions.fromJson(v));
      });
    }
    // Проверяем, если price тип int, преобразуем в double
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : (json['price'] is double)
            ? json['price']
            : 0.0; // Если цена не указана, устанавливаем 0.0
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['description'] = this.description;
    data['sizes'] = this.sizes;
    if (this.moreOptions != null) {
      data['moreOptions'] = this.moreOptions!.map((v) => v.toJson()).toList();
    }
    data['price'] = this.price;
    return data;
  }
}

class MoreOptions {
  String? name;
  double? price;

  MoreOptions({this.name, this.price});

  MoreOptions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    // Преобразуем цену в double, если она целое число
    price = (json['price'] is int)
        ? (json['price'] as int).toDouble()
        : json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    return data;
  }
}
