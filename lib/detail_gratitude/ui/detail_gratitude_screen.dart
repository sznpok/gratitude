import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/detail_gratitude/bloc/gratitude_delete_bloc/gratitude_delete_bloc.dart';
import 'package:gratitude_app/detail_gratitude/bloc/update_gratitude_bloc/update_gratitude_bloc.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';

import '../../list_gratitude/ui/list_gratitude_screen.dart';
import '../../utils/custom_progress_indicator.dart';
import '../../utils/size.dart';
import '../../utils/string_to_baseurl.dart';
import '../../utils/theme.dart';

class DetailGratitudeScreen extends StatefulWidget {
  const DetailGratitudeScreen({
    super.key,
    this.image,
    this.title,
    this.date,
    required this.id,
  });

  final String? title;
  final String id;
  final String? date;
  final String? image;

  @override
  State<DetailGratitudeScreen> createState() => _DetailGratitudeScreenState();
}

class _DetailGratitudeScreenState extends State<DetailGratitudeScreen> {
  final TextEditingController titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  bool isEdit = false;
  File? _image;
  final ImagePicker picker = ImagePicker();

  void chooseGalleryImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  void chooseCameraImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  @override
  void initState() {
    titleController.text = widget.title!;
    super.initState();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              fit: StackFit.loose,
              alignment: Alignment.topRight,
              children: [
                InkWell(
                  onTap: () {
                    if (isEdit) {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          chooseCameraImage();
                                        },
                                        icon: const Column(
                                          children: [
                                            Icon(Icons.camera),
                                            Text("Camera"),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          chooseGalleryImage();
                                        },
                                        icon: const Column(
                                          children: [
                                            Icon(Icons.photo),
                                            Text("Gallery"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          });
                    }
                  },
                  child: _image == null
                      ? CachedNetworkImage(
                          imageUrl: widget.image!,
                          fit: BoxFit.cover,
                          height: SizeConfig.screenHeight! * 0.5,
                          width: SizeConfig.screenWidth!,
                          errorWidget: (context, str, obj) {
                            return Image.asset(
                              "images/gratitude.png",
                              color: primaryColor,
                            );
                          },
                        )
                      : Image.file(_image!),
                ),
                Positioned(
                  top: SizeConfig.padding! * 0.1,
                  right: SizeConfig.padding! * 0.02,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(
                        SizeConfig.padding!,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.topLeft,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    readOnly: isEdit ? false : true,
                    canRequestFocus: true,
                    maxLines: 10,
                    textAlign: TextAlign.justify,
                    autofocus: isEdit ? true : true,
                    controller: titleController,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.1),
                      filled: isEdit ? true : false,
                      border: OutlineInputBorder(
                        borderSide: isEdit
                            ? const BorderSide(
                                color: secondaryColor,
                                width: 1,
                              )
                            : BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  isEdit
                      ? const Text('')
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "images/quote.png",
                              scale: 100,
                              color: primaryColor,
                            ),
                            Text(
                              "-${widget.date!}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.padding! * 0.05,
            ),
            !isEdit
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          shareImageWithText();
                        },
                        heroTag: "fab1",
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            SizeConfig.padding!,
                          ),
                        ),
                        child: const Icon(
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            isEdit = true;
                            _titleFocusNode.requestFocus();
                          });
                        },
                        heroTag: "fab2",
                        focusNode: _titleFocusNode,
                        backgroundColor: secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            SizeConfig.padding!,
                          ),
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: textColor,
                        ),
                      ),
                      BlocConsumer<GratitudeDeleteBloc, GratitudeDeleteState>(
                        listener: (context, state) {
                          if (state is GratitudeDeleteErrorState) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Error Occur While Deleting"),
                              backgroundColor: Colors.red,
                            ));
                          } else if (state is GratitudeDeleteSuccessState) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ListGratitudeScreen()),
                                (route) => false);
                          }
                        },
                        builder: (context, state) {
                          return state is GratitudeDeleteLoadingState
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : FloatingActionButton(
                                  onPressed: () {
                                    //CustomAlertProgressIndicator.showInputDialog(context);
                                    BlocProvider.of<GratitudeDeleteBloc>(
                                            context)
                                        .add(OnDeleteGratitudeDeleteEvent(
                                            widget.id));
                                  },
                                  heroTag: "fab3",
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      SizeConfig.padding!,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                );
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.padding! * 0.2,
                      ),
                    ],
                  )
                : BlocConsumer<UpdateGratitudeBloc, UpdateGratitudeState>(
                    listener: (context, state) {
                      if (state is UpdateGratitudeErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Error On updating"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is UpdateGratitudeSuccessState) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ListGratitudeScreen()),
                            (route) => false);
                      }
                    },
                    builder: (context, state) {
                      return state is UpdateGratitudeLoadingState
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                String? image = _image != null
                                    ? _image!.path
                                    : widget.image;
                                BlocProvider.of<UpdateGratitudeBloc>(context)
                                    .add(OnUpdateGratitudeEvent(
                                  widget.id,
                                  titleController.text,
                                  image!,
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: secondaryColor,
                                foregroundColor: textColor,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                fixedSize: Size(
                                  SizeConfig.screenWidth! * 0.7,
                                  SizeConfig.screenHeight! * 0.05,
                                ),
                              ),
                              child: const Text("Update"),
                            );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> shareImageWithText() async {
    try {
      // Download the image
      final dio = Dio();
      final Response<List<int>> response = await dio.get<List<int>>(
        widget.image!,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      ); // Specify responseType as bytes
      final bytes = response.data;

      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create a new file in the temporary directory
      final file = File('${tempDir.path}/image.png');

      // Write the downloaded bytes to the file
      await file.writeAsBytes(bytes!); // Ensure bytes is not null

      // Share the image using share_plus package
      await Share.shareXFiles([XFile(file.path)],
          text: titleController.text, subject: 'Gratitude App');
    } catch (e) {
      // Handle error if sharing fails
      log('Error sharing image: $e');
    }
  }
}
