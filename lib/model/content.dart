
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

}
