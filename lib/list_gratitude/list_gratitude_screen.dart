import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gratitude_app/detail_gratitude/detail_gratitude_screen.dart';
import 'package:gratitude_app/list_gratitude/custom_list_card.dart';

import '../post_gratitude/post_gratitude_screen.dart';
import '../utils/constant.dart';
import '../utils/size.dart';
import '../utils/theme.dart';

class ListGratitudeScreen extends StatefulWidget {
  const ListGratitudeScreen({super.key});

  @override
  State<ListGratitudeScreen> createState() => _ListGratitudeScreenState();
}

class _ListGratitudeScreenState extends State<ListGratitudeScreen> {
  bool isLoading = false;

  final String title =
      "I am so sorry and gratefull I am so sorry and gratefull that i had a productive white board session with Sijasd jfdlskjflk";
  final String image =
      "https://img.freepik.com/free-vector/gradient-orange-violet-abstract-background_23-2148453876.jpg?w=1380&t=st=1713165456~exp=1713166056~hmac=ad5b8e78ab87778ae8831e71f07df4402e7bd63ce66ae6687d93411afb367469";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Greeting"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 3)),
            lastDate: DateTime.now(),
            onDateSelected: (date) => log(date.toString()),
            leftMargin: 20,
            monthColor: primaryColor,
            dayColor: secondaryColor,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: primaryColor,
            dotsColor: secondaryColor,
            selectableDayPredicate: (date) => date.day != 23,
            locale: 'en_ISO',
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              padding: EdgeInsets.all(
                SizeConfig.padding! * 0.01,
              ),
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: CustomListCard(
                    title: title,
                    image: image,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailGratitudeScreen(
                          title: title,
                          image: image,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PostGratitudeScreen()));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeConfig.padding!),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
