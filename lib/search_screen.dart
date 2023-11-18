import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:task_sde/widgets/search_event_card.dart';
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
    return SearchEventCard(event: event);
  }
}
