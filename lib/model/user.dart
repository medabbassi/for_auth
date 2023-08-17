class User {
  String? name;
  String? email;
  String? phonenumber;
  String? country;
  String? location;

  User({this.name, this.email, this.phonenumber, this.country, this.location});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phonenumber = json['phonenumber'];
    country = json['country'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['phonenumber'] = this.phonenumber;
    data['country'] = this.country;
    data['location'] = this.location;
    return data;
  }
}
