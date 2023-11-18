import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../event_details.dart';
import '../model/content.dart';

class EventCard extends StatelessWidget {
  final Datum event;

  const EventCard({required this.event, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventDetailScreen(event: event)));
      },
      child: Card(
        color: Colors.white,
        elevation: 0.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                height: 108,
                child: Container(
                  height: 106,
                  width: 108,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(event.bannerImage),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DateFormat('E, MMM d • h:mm a').format(event.dateTime),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: const Color(0xff5669FF),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      event.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff120D26),
                          fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Wrap(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xff747688),
                          size: 20,
                        ),
                        Text(
                          '${event.venueName} •',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff747688),
                          ),
                        ),
                        Text(
                          '${event.venueCity}, ${event.venueCountry}',
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff747688),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
