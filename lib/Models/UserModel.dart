/// status : 1
/// message : "User login successfully"
/// data : {"id":"1","full_name":"Yagyesh Gupta","user_name":"yGupta","email":"y@gmail.com","phone":"7247388055","password":"123456","address":"vijaynagar,  Indore","city":"Indore","latitude":"22.7533","longitude":"75.8937","country_code":"+91","verified_user":"1","category_id":"1","sub_category_id":"1","gallery_images":null,"profile_image":"Picsart_23-02-11_23-34-31-740.jpg","user_type":"1","request_status":"Reject","reviews":null,"avg_ratings":null,"login_type":null,"created_at":"2023-07-20 02:46:03"}

class UserModel {
  UserModel({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  UserModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
UserModel copyWith({  num? status,
  String? message,
  Data? data,
}) => UserModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// id : "1"
/// full_name : "Yagyesh Gupta"
/// user_name : "yGupta"
/// email : "y@gmail.com"
/// phone : "7247388055"
/// password : "123456"
/// address : "vijaynagar,  Indore"
/// city : "Indore"
/// latitude : "22.7533"
/// longitude : "75.8937"
/// country_code : "+91"
/// verified_user : "1"
/// category_id : "1"
/// sub_category_id : "1"
/// gallery_images : null
/// profile_image : "Picsart_23-02-11_23-34-31-740.jpg"
/// user_type : "1"
/// request_status : "Reject"
/// reviews : null
/// avg_ratings : null
/// login_type : null
/// created_at : "2023-07-20 02:46:03"

class Data {
  Data({
      String? id, 
      String? fullName, 
      String? userName, 
      String? email, 
      String? phone, 
      String? password, 
      String? address, 
      String? city, 
      String? latitude, 
      String? longitude, 
      String? countryCode, 
      String? verifiedUser, 
      String? categoryId, 
      String? subCategoryId, 
      dynamic galleryImages, 
      String? profileImage, 
      String? userType, 
      String? requestStatus, 
      dynamic reviews, 
      dynamic avgRatings, 
      dynamic loginType, 
      String? createdAt,}){
    _id = id;
    _fullName = fullName;
    _userName = userName;
    _email = email;
    _phone = phone;
    _password = password;
    _address = address;
    _city = city;
    _latitude = latitude;
    _longitude = longitude;
    _countryCode = countryCode;
    _verifiedUser = verifiedUser;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _galleryImages = galleryImages;
    _profileImage = profileImage;
    _userType = userType;
    _requestStatus = requestStatus;
    _reviews = reviews;
    _avgRatings = avgRatings;
    _loginType = loginType;
    _createdAt = createdAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _userName = json['user_name'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _address = json['address'];
    _city = json['city'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _countryCode = json['country_code'];
    _verifiedUser = json['verified_user'];
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _galleryImages = json['gallery_images'];
    _profileImage = json['profile_image'];
    _userType = json['user_type'];
    _requestStatus = json['request_status'];
    _reviews = json['reviews'];
    _avgRatings = json['avg_ratings'];
    _loginType = json['login_type'];
    _createdAt = json['created_at'];
  }
  String? _id;
  String? _fullName;
  String? _userName;
  String? _email;
  String? _phone;
  String? _password;
  String? _address;
  String? _city;
  String? _latitude;
  String? _longitude;
  String? _countryCode;
  String? _verifiedUser;
  String? _categoryId;
  String? _subCategoryId;
  dynamic _galleryImages;
  String? _profileImage;
  String? _userType;
  String? _requestStatus;
  dynamic _reviews;
  dynamic _avgRatings;
  dynamic _loginType;
  String? _createdAt;
Data copyWith({  String? id,
  String? fullName,
  String? userName,
  String? email,
  String? phone,
  String? password,
  String? address,
  String? city,
  String? latitude,
  String? longitude,
  String? countryCode,
  String? verifiedUser,
  String? categoryId,
  String? subCategoryId,
  dynamic galleryImages,
  String? profileImage,
  String? userType,
  String? requestStatus,
  dynamic reviews,
  dynamic avgRatings,
  dynamic loginType,
  String? createdAt,
}) => Data(  id: id ?? _id,
  fullName: fullName ?? _fullName,
  userName: userName ?? _userName,
  email: email ?? _email,
  phone: phone ?? _phone,
  password: password ?? _password,
  address: address ?? _address,
  city: city ?? _city,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  countryCode: countryCode ?? _countryCode,
  verifiedUser: verifiedUser ?? _verifiedUser,
  categoryId: categoryId ?? _categoryId,
  subCategoryId: subCategoryId ?? _subCategoryId,
  galleryImages: galleryImages ?? _galleryImages,
  profileImage: profileImage ?? _profileImage,
  userType: userType ?? _userType,
  requestStatus: requestStatus ?? _requestStatus,
  reviews: reviews ?? _reviews,
  avgRatings: avgRatings ?? _avgRatings,
  loginType: loginType ?? _loginType,
  createdAt: createdAt ?? _createdAt,
);
  String? get id => _id;
  String? get fullName => _fullName;
  String? get userName => _userName;
  String? get email => _email;
  String? get phone => _phone;
  String? get password => _password;
  String? get address => _address;
  String? get city => _city;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get countryCode => _countryCode;
  String? get verifiedUser => _verifiedUser;
  String? get categoryId => _categoryId;
  String? get subCategoryId => _subCategoryId;
  dynamic get galleryImages => _galleryImages;
  String? get profileImage => _profileImage;
  String? get userType => _userType;
  String? get requestStatus => _requestStatus;
  dynamic get reviews => _reviews;
  dynamic get avgRatings => _avgRatings;
  dynamic get loginType => _loginType;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['user_name'] = _userName;
    map['email'] = _email;
    map['phone'] = _phone;
    map['password'] = _password;
    map['address'] = _address;
    map['city'] = _city;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['country_code'] = _countryCode;
    map['verified_user'] = _verifiedUser;
    map['category_id'] = _categoryId;
    map['sub_category_id'] = _subCategoryId;
    map['gallery_images'] = _galleryImages;
    map['profile_image'] = _profileImage;
    map['user_type'] = _userType;
    map['request_status'] = _requestStatus;
    map['reviews'] = _reviews;
    map['avg_ratings'] = _avgRatings;
    map['login_type'] = _loginType;
    map['created_at'] = _createdAt;
    return map;
  }

}