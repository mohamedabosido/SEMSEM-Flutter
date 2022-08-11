import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/fb_storage_controller.dart';
import 'package:tokoto/prefs/user_preferences_controller.dart';

final profilePhotoProvider =
    FutureProvider.family<String, String>((ref, imageName) async {
  return await FirebaseStorage.instance
      .ref('/profile picture/$imageName')
      .getDownloadURL();
});

class ProfilePictureWidget extends ConsumerWidget {
  const ProfilePictureWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storage = FbStorage();
    final profilePic = ref.watch(profilePhotoProvider(
        'User${UserPreferencesController().user.id}-ProfilePicture'));
    return Stack(
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
              final ImagePicker picker = ImagePicker();
              final XFile? photo =
                  await picker.pickImage(source: ImageSource.gallery);
              storage
                  .uploadImage(
                      path: photo!.path,
                      fileName:
                          'User${UserPreferencesController().user.id}-ProfilePicture')
                  .then((value) => ref.refresh(profilePhotoProvider(
                      'User${UserPreferencesController().user.id}-ProfilePicture')));
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
    );
  }
}
