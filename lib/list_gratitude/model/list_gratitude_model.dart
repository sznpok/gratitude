class ListGratitudeModel {
  List<Gg>? gg;

  ListGratitudeModel({this.gg});

  ListGratitudeModel.fromJson(Map<String, dynamic> json) {
    if (json['gg'] != null) {
      gg = <Gg>[];
      json['gg'].forEach((v) {
        gg!.add(Gg.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gg != null) {
      data['gg'] = gg!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gg {
  Profile? profile;
  String? sId;
  String? title;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Gg(
      {this.profile,
      this.sId,
      this.title,
      this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Gg.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? Profile.fromJson(json['profile']) : null;
    sId = json['_id'];
    title = json['title'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['createdBy'] = createdBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Profile {
  String? publicId;
  String? url;

  Profile({this.publicId, this.url});

  Profile.fromJson(Map<String, dynamic> json) {
    publicId = json['public_id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['public_id'] = publicId;
    data['url'] = url;
    return data;
  }
}
