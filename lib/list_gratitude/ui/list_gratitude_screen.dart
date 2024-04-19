import 'dart:developer';

import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/detail_gratitude/ui/detail_gratitude_screen.dart';
import 'package:gratitude_app/list_gratitude/ui/custom_list_card.dart';
import 'package:gratitude_app/list_gratitude/list_gratitude_bloc/list_gratitude_bloc.dart';
import 'package:gratitude_app/profile/profile_screen.dart';
import 'package:gratitude_app/utils/convert_date.dart';
import 'package:intl/intl.dart';

import '../../post_gratitude/post_gratitude_screen.dart';
import '../../utils/size.dart';
import '../../utils/theme.dart';
import '../model/list_gratitude_model.dart';

class ListGratitudeScreen extends StatefulWidget {
  const ListGratitudeScreen({super.key});

  @override
  State<ListGratitudeScreen> createState() => _ListGratitudeScreenState();
}

class _ListGratitudeScreenState extends State<ListGratitudeScreen> {
  bool isLoading = false;

  String gratitudeDate = "";

  @override
  void initState() {
    BlocProvider.of<ListGratitudeBloc>(context)
        .add(LoadingListGratitudeEvent());
    super.initState();
  }

  /*List<Gg> findGratitudeList(List<Gg> gratitudeModel, String date) {
    final List<Gg> gratitudeList = [];
    for (int i = 0; i < gratitudeModel.length; i++) {
      if (convertDateFormat(gratitudeModel[i].createdAt.toString()) ==
          date.toString()) {
        gratitudeList.add(gratitudeModel[i]);
      }
    }
    return gratitudeList;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Greeting"),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<ListGratitudeBloc, ListGratitudeState>(
        builder: (context, state) {
          if (state is ListGratitudeErrorState) {
            return Center(
              child: Text(
                "There is no any gratitude data\n Please Click button below to create new gratitude",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                    ),
              ),
            );
          } else if (state is ListGratitudeLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is ListGratitudeSuccessState) {
            return Column(
              children: [
                CalendarTimeline(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 3)),
                  lastDate: DateTime.now(),
                  onDateSelected: (date) {
                    gratitudeDate = date.toString();
                    //(context as Element).markNeedsBuild();
                  },
                  leftMargin: 20,
                  monthColor: primaryColor,
                  dayColor: secondaryColor,
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor: primaryColor,
                  dotsColor: secondaryColor,
                  selectableDayPredicate: (date) {
                    // (context as Element).markNeedsBuild();

                    return date.day != 23;
                  },
                  locale: 'en_ISO',
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.01,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.listGratitudeModel!.gg!.length,
                    padding: EdgeInsets.all(
                      SizeConfig.padding! * 0.01,
                    ),
                    itemBuilder: (context, i) {
                      final data = state.listGratitudeModel!.gg!;
                      return GestureDetector(
                        child: CustomListCard(
                          title: data[i].title!,
                          image: data[i].profile!.url!,
                        ),
                        onTap: () {
                          DateTime initialDate = DateTime.parse(
                              state.listGratitudeModel!.gg![i].createdAt!);
                          String finalDateString =
                              DateFormat('MMMM d, yyyy').format(initialDate);
                          finalDateString = finalDateString.replaceRange(
                              0, 1, finalDateString[0].toUpperCase());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailGratitudeScreen(
                                title: state.listGratitudeModel!.gg![i].title
                                    .toString(),
                                id: state.listGratitudeModel!.gg![i].sId!,
                                image: state
                                    .listGratitudeModel!.gg![i].profile!.url,
                                date: finalDateString,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                /*Expanded(
                  child: ListView.builder(
                    itemCount: state.listGratitudeModel!.gg!.length,
                    padding: EdgeInsets.all(
                      SizeConfig.padding! * 0.01,
                    ),
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        child: CustomListCard(
                          title:
                              state.listGratitudeModel!.gg![i].title.toString(),
                          image: state.listGratitudeModel!.gg![i].profile!.url!,
                        ),
                        onTap: () {
                          final String date = convertDateFormat(state
                              .listGratitudeModel!.gg![i].createdAt
                              .toString());
                          log(date.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailGratitudeScreen(
                                title: state.listGratitudeModel!.gg![i].title
                                    .toString(),
                                id: state.listGratitudeModel!.gg![i].sId!,
                                image: state
                                    .listGratitudeModel!.gg![i].profile!.url,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),*/
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
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
          color: Colors.white,
        ),
      ),
    );
  }
}
