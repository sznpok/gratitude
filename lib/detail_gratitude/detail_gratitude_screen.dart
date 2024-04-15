import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';

import '../utils/size.dart';
import '../utils/theme.dart';

class DetailGratitudeScreen extends StatefulWidget {
  const DetailGratitudeScreen({
    super.key,
    this.image,
    this.title,
  });

  final String? title;
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
                isEdit
                    ? const Text('')
                    : Image.asset(
                        "images/quote.png",
                        scale: 100,
                        color: primaryColor,
                      ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  readOnly: isEdit ? false : true,
                  canRequestFocus: true,
                  maxLines: 10,
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
                    : Image.asset(
                        "images/quote.png",
                        scale: 100,
                        color: primaryColor,
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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConfig.padding!,
                        ),
                      ),
                      child: const Icon(
                        Icons.share,
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
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConfig.padding!,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      heroTag: "fab3",
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          SizeConfig.padding!,
                        ),
                      ),
                      child: const Icon(
                        Icons.delete,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.padding! * 0.2,
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    fixedSize: Size(
                      SizeConfig.screenWidth! * 0.7,
                      SizeConfig.screenHeight! * 0.05,
                    ),
                  ),
                  child: const Text("Update"),
                ),
        ],
      ),
    ));
  }

  Future<void> shareImageWithText() async {
    try {
      final dio = Dio();
      final response = await dio.get(widget.image!);
      if (response.statusCode == 200) {
        final bytes = response.data;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/image.png');
        await file.writeAsBytes(bytes);

        await Share.shareXFiles([XFile(file.path)],
            text: titleController.text, subject: 'Gratitude App');
      } else {
        log('Error: Unexpected response code ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching or sharing image: $e');
    }
  }
}
