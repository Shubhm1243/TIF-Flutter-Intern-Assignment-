import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:task_sde/event_details.dart';
import 'model/content.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearch = false;

  late Future<List<Datum>> _eventsFuture;
  late List<Datum> _allEvents = [];
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _eventsFuture = _fetchEvents();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Dispose the focus node when it's no longer needed
    super.dispose();
  }

  Future<List<Datum>> _fetchEvents() async {
    final response = await http.get(Uri.parse(
        'https://sde-007.api.assignment.theinternetfolks.works/v1/event'));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      _allEvents = List<Datum>.from(
          jsonData['content']['data'].map((x) => Datum.fromJson(x)));
      return _allEvents;
    } else {
      throw Exception('Failed to load events');
    }
  }

  List<Datum> _searchEvents(String query) {
    return _allEvents.where((event) {
      return event.title.toLowerCase().contains(query.toLowerCase()) ||
          event.venueName.toLowerCase().contains(query.toLowerCase()) ||
          event.venueCity.toLowerCase().contains(query.toLowerCase()) ||
          event.venueCountry.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Search',
            style: GoogleFonts.inter(
                color: const Color(0xff120D26), fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                focusNode: _focusNode,
                autofocus: true,
                controller: _textEditingController,
                onChanged: (value) {
                  setState(() {
                    _eventsFuture = Future.value(_searchEvents(value));
                  });
                },
                decoration: InputDecoration(
                    hintText: 'Type Event Name...',
                    hintStyle: GoogleFonts.inter(
                        fontSize: 20, fontWeight: FontWeight.w400),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xff7974E7),
                    ),
                    suffixIcon: _textEditingController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _textEditingController.clear();
                              FocusScope.of(context).unfocus();
                              _eventsFuture = Future.value(_allEvents);
                            },
                          )
                        : null,
                    border: InputBorder.none),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Datum>>(
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
                        return buildEventItem(event);
                      },
                    );
                  } else {
                    return const Center(child: Text('No data available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventItem(Datum event) {
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
