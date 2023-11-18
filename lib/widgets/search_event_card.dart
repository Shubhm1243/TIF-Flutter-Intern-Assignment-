import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../event_details.dart';
import '../model/content.dart';

class SearchEventCard extends StatelessWidget {
  final Datum event;

  const SearchEventCard({required this.event, Key? key}) : super(key: key);

  String formatDate(DateTime dateTime) {
    final day = dateTime.day.toString();
    final month = DateFormat.MMM().format(dateTime).toUpperCase();
    final weekday = DateFormat.E().format(dateTime).toUpperCase();
    final time = DateFormat.jm().format(dateTime).toUpperCase();

    String daySuffix;
    if (day.endsWith('1') && day != '11') {
      daySuffix = 'ST';
    } else if (day.endsWith('2') && day != '12') {
      daySuffix = 'ND';
    } else if (day.endsWith('3') && day != '13') {
      daySuffix = 'RD';
    } else {
      daySuffix = 'TH';
    }

    return '$day$daySuffix $month - $weekday - $time';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EventDetailScreen(event: event),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          color: Colors.white,
          elevation: 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 108,
                  child: Container(
                    height: 100,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      formatDate(event.dateTime),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color(0xff5669FF),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      event.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff120D26),
                          fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
