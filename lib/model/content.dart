import 'dart:convert';

// class Temperatures {
//   Content content;
//   bool status;
//
//   Temperatures({
//     required this.content,
//     required this.status,
//   });
//
//   factory Temperatures.fromRawJson(String str) => Temperatures.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Temperatures.fromJson(Map<String, dynamic> json) => Temperatures(
//     content: Content.fromJson(json["content"]),
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "content": content.toJson(),
//     "status": status,
//   };
// }
//
// class Content {
//   List<Datum> data;
//   Meta meta;
//
//   Content({
//     required this.data,
//     required this.meta,
//   });
//
//   factory Content.fromRawJson(String str) => Content.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     meta: Meta.fromJson(json["meta"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     "meta": meta.toJson(),
//   };
// }

class Datum {
  int id;
  String title;
  String description;
  String bannerImage;
  DateTime dateTime;
  String organiserName;
  String organiserIcon;
  String venueName;
  String venueCity;
  String venueCountry;

  Datum({
    required this.id,
    required this.title,
    required this.description,
    required this.bannerImage,
    required this.dateTime,
    required this.organiserName,
    required this.organiserIcon,
    required this.venueName,
    required this.venueCity,
    required this.venueCountry,
  });

  // factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  // String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      bannerImage: json["banner_image"],
      dateTime: DateTime.parse(json["date_time"]),
      organiserName: json["organiser_name"],
      organiserIcon: json["organiser_icon"],
      venueName: json["venue_name"],
      venueCity: json["venue_city"],
      venueCountry: json["venue_country"],
    );
  }

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "title": title,
  //   "description": description,
  //   "banner_image": bannerImage,
  //   "date_time": dateTime.toIso8601String(),
  //   "organiser_name": organiserName,
  //   "organiser_icon": organiserIcon,
  //   "venue_name": venueName,
  //   "venue_city": venueCity,
  //   "venue_country": venueCountry,
  // };
}

class Meta {
  int total;

  Meta({
    required this.total,
  });

  factory Meta.fromRawJson(String str) => Meta.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
  };
}
