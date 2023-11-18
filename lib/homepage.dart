import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:task_sde/event_details.dart';
import 'package:task_sde/seacrh_screen.dart';
import 'model/content.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Datum>> _eventsFuture;
  // late List<Datum> _allEvents = [];

  @override
  void initState() {
    super.initState();
    _eventsFuture = _fetchEvents();
  }

  Future<List<Datum>> _fetchEvents() async {
    final response = await http.get(Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return List<Datum>.from(
          jsonData['content']['data'].map((x) => Datum.fromJson(x)));
    } else {
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SearchPage()));
              },
              icon: const Icon(
                Icons.search,
                color: Color(0xff110c26),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Color(0xff110c26),
              ),
            ),
          ],
          title: Text(
            'Events',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              color: const Color(0xff110c26),
            ),
          ),
        ),
        body: FutureBuilder<List<Datum>>(
          future: _eventsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var event = snapshot.data![index];
                  // return ListTile(
                  //   leading: Image.network(event.bannerImage),
                  //   title: Text(event.title),
                  //   subtitle: Text('${event.venueName}, ${event.venueCity}'),
                  //   // Add more details here as needed
                  // );
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              EventDetailScreen(event: event)));
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat('E, MMM d • h:mm a')
                                        .format(event.dateTime),
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff5668ff),
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
                                        color: const Color(0xff110c26),
                                        fontSize: 18),
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
                                          )),
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
                },
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
