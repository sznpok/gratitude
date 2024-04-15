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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Greeting!!!"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Today"),
              Text('April 8th'),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              padding: EdgeInsets.all(
                SizeConfig.padding! * 0.01,
              ),
              itemBuilder: (context, i) {
                return const CustomListCard();
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
