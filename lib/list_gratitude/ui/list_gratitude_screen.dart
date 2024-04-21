import 'dart:developer';
import 'package:easy_date_timeline/easy_date_timeline.dart';
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

  List<Gg> gratitudeList = [];

  @override
  void initState() {
    DateTime currentDate = DateTime.now();
    gratitudeDate = currentDate.toString();
    BlocProvider.of<ListGratitudeBloc>(context)
        .add(LoadingListGratitudeEvent(gratitudeDate));
    super.initState();
  }

  List<DateTime> _calculateDisabledDates() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final disabledDates = <DateTime>[];
    for (var i = tomorrow;
        i.isBefore(DateTime.now().add(const Duration(days: 365)));
        i = i.add(const Duration(days: 1))) {
      disabledDates.add(i);
    }
    return disabledDates;
  }

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
            return Image.asset(
              "images/nodatafound.png",
              fit: BoxFit.cover,
            );
          } else if (state is ListGratitudeLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is ListGratitudeSuccessState) {
            return Column(
              children: [
                /*CalendarTimeline(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 3)),
                  lastDate: DateTime.now(),
                  onDateSelected: (date) {
                    gratitudeDate = date.toString();
                    gratitudeList = state.listGratitudeModel!.gg!
                        .where((gratitude) =>
                            convertDateFormat(gratitude.createdAt.toString()) ==
                            gratitudeDate)
                        .toList();

                    (context as Element).markNeedsBuild();
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
                ),*/
                EasyDateTimeLine(
                  initialDate: DateTime.now(),
                  disabledDates: _calculateDisabledDates(),
                  onDateChange: (selectedDate) {
                    gratitudeDate = selectedDate.toString();
                    gratitudeList = state.listGratitudeModel!.gg!
                        .where((gratitude) =>
                            convertDateFormat(gratitude.createdAt.toString()) ==
                            gratitudeDate)
                        .toList();
                    (context as Element).markNeedsBuild();
                  },
                  activeColor: primaryColor,
                  dayProps: const EasyDayProps(
                    activeDayStyle: DayStyle(
                      borderRadius: 8.0,
                    ),
                    inactiveDayStyle: DayStyle(
                      borderRadius: 8.0,
                    ),
                  ),
                  timeLineProps: const EasyTimeLineProps(
                    hPadding: 8.0, // padding from left and right
                    separatorPadding: 12.0, // padding between days
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.01,
                ),
                gratitudeList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: gratitudeList.length,
                          padding: EdgeInsets.all(
                            SizeConfig.padding! * 0.01,
                          ),
                          itemBuilder: (context, i) {
                            final data = gratitudeList;
                            return GestureDetector(
                              child: CustomListCard(
                                title: data[i].title!,
                                image: data[i].profile!.url!,
                              ),
                              onTap: () {
                                DateTime initialDate =
                                    DateTime.parse(gratitudeList[i].createdAt!);
                                String finalDateString =
                                    DateFormat('MMMM d, yyyy')
                                        .format(initialDate);
                                finalDateString = finalDateString.replaceRange(
                                    0, 1, finalDateString[0].toUpperCase());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailGratitudeScreen(
                                      title: gratitudeList[i].title.toString(),
                                      id: gratitudeList[i].sId!,
                                      image: gratitudeList[i].profile!.url,
                                      date: finalDateString,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "images/nodatafound.png",
                              fit: BoxFit.fitWidth,
                              width: SizeConfig.screenWidth! * 0.3,
                            ),
                            Text(
                              "No Data Found !!!",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: primaryColor,
                                  ),
                            ),
                          ],
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
