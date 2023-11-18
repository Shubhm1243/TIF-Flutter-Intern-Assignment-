import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:task_sde/widgets/custom_button.dart';
import 'model/content.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventDetailScreen extends StatefulWidget {
  final Datum event;
  final maxWords = 10;


  const EventDetailScreen({Key? key, required this.event,}) : super(key: key);

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
                        fontSize: 24,
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
                              color: const Color(0xff120D26),
                              fontWeight: FontWeight.w400,
                              fontSize: 35),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 61,
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
                                        fontSize: 15),
                                  ),
                                  Text(
                                    'Organizer',
                                    style: GoogleFonts.inter(
                                        color: const Color(0xff6f6e8f),
                                        fontSize: 12,
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
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff120D26),
                                  ),
                                ),
                                Text(
                                  '${DateFormat('EEEE, h:mm a').format(widget.event.dateTime)} - ${DateFormat('h:mm a').format(widget.event.dateTime.add(const Duration(hours: 5)))}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
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
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff120D26),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${widget.event.venueCity},${widget.event.venueCountry}',
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
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
                              color: const Color(0xff120D26),
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: getLimitedDescription(
                                      widget.event.description),
                                  style: GoogleFonts.inter(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff120D26),
                                  ),
                                ),
                                if (widget.event.description.split(' ').length >
                                    maxWords)
                                  TextSpan(
                                    text: isExpanded
                                        ? ' Read less...'
                                        : ' Read more...',
                                    style: const TextStyle(
                                      color: Color(0xFF5669FF),
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
                        const Center(
                          child: CustomButton(),
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
