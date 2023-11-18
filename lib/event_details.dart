import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'model/content.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailScreen extends StatefulWidget {
  final Datum event;
  final maxWords = 10;

  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool isExpanded = false;
  final maxWords = 10;

  String getLimitedDescription(String description) {
    List<String> words = description.split(' ');

    if (isExpanded) {
      return description;
    } else if (words.length <= widget.maxWords) {
      return description;
    } else {
      return words.take(widget.maxWords).join(' ') + '.';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget getImageWidget(String imageUrl) {
      if (imageUrl.toLowerCase().endsWith('.svg')) {
        return SvgPicture.network(
          imageUrl,
          placeholderBuilder: (BuildContext context) =>
              const CircularProgressIndicator(),
          width: 65,
          height: 65,
        );
      } else {
        return Image.network(
          imageUrl,
          width: 65,
          height: 65,
          fit: BoxFit.cover,
        );
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    'Event Details',
                    style: GoogleFonts.inter(
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w500),
                  ),
                  expandedHeight: 200, // Adjust the height as needed
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      widget.event.bannerImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  actions: [
                    // Text('Event Details',style: GoogleFonts.inter(color: Colors.black54),),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.bookmark,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.event.title,
                          style: GoogleFonts.inter(
                              color: const Color(0xff110c26),
                              fontWeight: FontWeight.w400,
                              fontSize: 35),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 65,
                              width: 65,
                              child: getImageWidget(widget.event.organiserIcon),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.event.organiserName,
                                    style: GoogleFonts.inter(
                                        color: const Color(0xff0d0c26),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    'Organizer',
                                    style: GoogleFonts.inter(
                                        color: const Color(0xff6f6e8f),
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFEEF0FF),
                              ),
                              child: const Icon(
                                Icons.calendar_month,
                                size: 30,
                                color: Color(0xFF5769FF),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  DateFormat('d MMMM, y')
                                      .format(widget.event.dateTime),
                                  // .format(event.dateTime),
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff110c26),
                                  ),
                                ),
                                Text(
                                  '${DateFormat('EEEE, h:mm a').format(widget.event.dateTime)} - ${DateFormat('h:mm a').format(widget.event.dateTime.add(const Duration(hours: 5)))}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff747688),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFEEF0FF),
                              ),
                              child: const Icon(
                                Icons.location_on,
                                size: 30,
                                color: Color(0xFF5769FF),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.event.venueName,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff110c26),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.event.venueCity},${widget.event.venueCountry}',
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff747688),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        Text(
                          'About Event',
                          style: GoogleFonts.inter(
                              color: const Color(0xff110c26), fontSize: 24),
                        ),
                        // Text(
                        //   event.description,
                        //   style: GoogleFonts.inter(color: const Color(0xff110c26)),
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: getLimitedDescription(
                                      widget.event.description),
                                  style: GoogleFonts.inter(
                                      color: const Color(0xff110c26)),
                                ),
                                if (widget.event.description.split(' ').length >
                                    maxWords)
                                  TextSpan(
                                    text:
                                        isExpanded ? ' Read less...' : ' Read more...',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          isExpanded = !isExpanded;
                                        });
                                      },
                                  ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            height: 58,
                            width: 271,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x3f6f7ec8),
                                  offset: Offset(0, 10),
                                  blurRadius: 17.5,
                                ),
                              ],
                              color: const Color(0xff5668ff),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'BOOK NOW',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.inter(
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Color(0xFF3D54F1)),
                                    child: const Icon(
                                      Icons.arrow_forward_rounded,
                                      color: Color(0xffffffff),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
