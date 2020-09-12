class restaurant {
  int totalEntries;
  int perPage;
  int currentPage;
  List<Restaurants> restaurants;

  restaurant(
      {this.totalEntries, this.perPage, this.currentPage, this.restaurants});

  restaurant.fromJson(Map<String, dynamic> json) {
    totalEntries = json['total_entries'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    if (json['restaurants'] != null) {
      restaurants = new List<Restaurants>();
      json['restaurants'].forEach((v) {
        restaurants.add(new Restaurants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_entries'] = this.totalEntries;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    if (this.restaurants != null) {
      data['restaurants'] = this.restaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurants {
  int id;
  String name;
  String address;
  String city;
  String state;
  String area;
  String postalCode;
  String country;
  String phone;
  double lat;
  double lng;
  int price;
  String reserveUrl;
  String mobileReserveUrl;
  String imageUrl;

  Restaurants(
      {this.id,
      this.name,
      this.address,
      this.city,
      this.state,
      this.area,
      this.postalCode,
      this.country,
      this.phone,
      this.lat,
      this.lng,
      this.price,
      this.reserveUrl,
      this.mobileReserveUrl,
      this.imageUrl});

  Restaurants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    area = json['area'];
    postalCode = json['postal_code'];
    country = json['country'];
    phone = json['phone'];
    lat = json['lat'];
    lng = json['lng'];
    price = json['price'];
    reserveUrl = json['reserve_url'];
    mobileReserveUrl = json['mobile_reserve_url'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['area'] = this.area;
    data['postal_code'] = this.postalCode;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['price'] = this.price;
    data['reserve_url'] = this.reserveUrl;
    data['mobile_reserve_url'] = this.mobileReserveUrl;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
