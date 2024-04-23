import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gratitude_app/post_gratitude/bloc/post_gratitude_bloc/post_gratitude_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../list_gratitude/ui/list_gratitude_screen.dart';
import '../utils/constant.dart';
import '../utils/size.dart';
import '../utils/string_to_baseurl.dart';
import '../utils/theme.dart';

class PostGratitudeScreen extends StatefulWidget {
  const PostGratitudeScreen({super.key});

  @override
  State<PostGratitudeScreen> createState() => _PostGratitudeScreenState();
}

class _PostGratitudeScreenState extends State<PostGratitudeScreen> {
  final TextEditingController titleController = TextEditingController();

  File? _image;

  final ImagePicker picker = ImagePicker();

  void chooseGalleryImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _image = File(image.path);
      (context as Element).markNeedsBuild();
    }
  }

  void chooseCameraImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _image = File(image.path);
      (context as Element).markNeedsBuild();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Greeting here'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(SizeConfig.padding! * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _image == null
                  ? Container(
                      height: SizeConfig.screenHeight! * 0.3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                      ),
                    )
                  : ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        width: SizeConfig.screenWidth,
                        height: 0.3 * SizeConfig.screenHeight!,
                      ),
                    ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.05,
              ),
              FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
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
                },
                foregroundColor: Colors.white,
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SizeConfig.padding!),
                ),
                child: const Icon(
                  Icons.camera_alt,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.05,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                controller: titleController,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Take a moment to reflect",
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(SizeConfig.padding! * 0.05),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(8.0),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.02,
              ),
              BlocConsumer<PostGratitudeBloc, PostGratitudeState>(
                listener: (context, state) {
                  if (state is PostGratitudeErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error to post"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is PostGratitudeSuccessState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListGratitudeScreen()),
                        (route) => false);
                  }
                },
                builder: (context, state) {
                  return state is PostGratitudeLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            if (_image != null ||
                                titleController.text.isNotEmpty) {
                              if (_image == null) {
                                BlocProvider.of<PostGratitudeBloc>(context).add(
                                  OnPostGratitudeEvent(
                                    titleController.text,
                                    "",
                                  ),
                                );
                              } else {
                                BlocProvider.of<PostGratitudeBloc>(context).add(
                                  OnPostGratitudeEvent(
                                    titleController.text,
                                    _image!.path,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "please Either enter text or choose image"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: secondaryColor,
                            // foregroundColor: Colors.white,
                            textStyle:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                            fixedSize: Size(
                              SizeConfig.screenWidth!,
                              SizeConfig.screenHeight! * 0.01,
                            ),
                          ),
                          child: const Text("Create"),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
