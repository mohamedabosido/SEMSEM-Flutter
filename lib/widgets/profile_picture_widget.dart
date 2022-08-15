import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_storage_controller.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';
import 'package:tokoto/widgets/app_button.dart';

final profilePhotoProvider =
    FutureProvider.family<String, String>((ref, imageName) async {
  return await FbStorage().storage
      .ref('/profile picture/$imageName')
      .getDownloadURL();
});

class ProfilePictureWidget extends ConsumerStatefulWidget {
  const ProfilePictureWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends ConsumerState<ProfilePictureWidget> with Helpers{
  @override
  Widget build(BuildContext context) {
    final profilePic = ref.watch(profilePhotoProvider(
        'User-${UserPreferencesController().user.id}-ProfilePicture'));
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          profilePic.when(
            data: (data) {
              return CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(data),
                backgroundColor: Theme.of(context).backgroundColor,
              );
            },
            error: (error, stack) {
              return ProfilePicture(
                name:
                    '${UserPreferencesController().user.fName} ${UserPreferencesController().user.lName}',
                radius: 70,
                fontsize: 25,
                count: 2,
                random: false,
              );
            },
            loading: () {
              return Shimmer.fromColors(
                baseColor: kOffOrangeColor,
                highlightColor: Theme.of(context).backgroundColor,
                child: const CircleAvatar(radius: 70),
              );
            },
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close)),
                        const Text('Choose an Option'),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                            text: 'Gallery',
                            onPressed: () {
                              pickImage(ImageSource.gallery)
                                  .whenComplete(() => cropImage());
                            }),
                        const SizedBox(height: kDefaultPadding / 2),
                        AppButton(
                            text: 'Camera',
                            onPressed: () {
                              pickImage(ImageSource.camera)
                                  .whenComplete(() => cropImage());
                            }),
                      ],
                    ),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 23,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: SvgPicture.asset(
                    'images/Camera Icon.svg',
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  File? pickedFile;
  File? croppedFile;

  Future pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    var photo = await picker.pickImage(source: source);
    try {
      if (photo != null) {
        var kFile = File(photo.path);
        setState(() {
          pickedFile = kFile;
        });
      }
    } catch (e) {
      return;
    }
  }

  Future cropImage() async {
    CroppedFile? file = await ImageCropper().cropImage(
      sourcePath: pickedFile!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        IOSUiSettings(title: 'Cropper'),
      ],
    );
    if (file != null) {
      setState(() {
        croppedFile = File(file.path);
      });
      FbStorage()
          .uploadImage(
          path: croppedFile!.path,
          fileName:
          'User-${UserPreferencesController().user.id}-ProfilePicture')
          .then((value) => ref.refresh(
          profilePhotoProvider(
              'User-${UserPreferencesController().user.id}-ProfilePicture')));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      showSnackBar(context: context, message: 'Uploaded Successfully , Please Wait ...');
    }
  }
}
