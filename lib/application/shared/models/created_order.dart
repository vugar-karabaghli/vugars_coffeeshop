class CreatedOrder {
  String? fullName;
  String? phoneNumber;
  String? address;
  List<Items>? items;
  double? totalPrice;
  String? created;

  CreatedOrder(
      {this.fullName,
      this.phoneNumber,
      this.address,
      this.items,
      this.totalPrice,
      this.created});

  CreatedOrder.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalPrice = (json['totalPrice'] is int)
        ? (json['totalPrice'] as int).toDouble()
        : json['totalPrice'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['address'] = this.address;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['totalPrice'] = this.totalPrice;
    data['created'] = this.created;
    return data;
  }
}

class Items {
  String? name;
  int? qty;
  double? unitPrice;
  double? subtotal;

  Items({this.name, this.qty, this.unitPrice, this.subtotal});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    qty = json['qty'];
    unitPrice = json['unitPrice'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['qty'] = this.qty;
    data['unitPrice'] = this.unitPrice;
    data['subtotal'] = this.subtotal;
    return data;
  }
}