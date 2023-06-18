class UserModel {
  String? sId;
  String? fullName;
  String? email;
  String? password;
  String? phoneNumber;
  String? city;
  String? state;
  int? profileProgress;
  String? id;
  String? updatedOn;
  String? createdOn;

  UserModel(
      {this.sId,
        this.fullName,
        this.email,
        this.password,
        this.phoneNumber,
        this.city,
        this.state,
        this.profileProgress,
        this.id,
        this.updatedOn,
        this.createdOn});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['full_name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    city = json['city'];
    state = json['state'];
    profileProgress = json['profileProgress'];
    id = json['id'];
    updatedOn = json['updated_on'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phoneNumber'] = this.phoneNumber;
    data['city'] = this.city;
    data['state'] = this.state;
    data['profileProgress'] = this.profileProgress;
    data['id'] = this.id;
    data['updated_on'] = this.updatedOn;
    data['created_on'] = this.createdOn;
    return data;
  }
}
