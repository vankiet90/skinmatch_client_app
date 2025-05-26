import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopupGallery extends StatelessWidget {
  final Function(String) onSelectImage;
  final Function() onTakeAPhoto;

  const PopupGallery(
      {super.key, required this.onSelectImage, required this.onTakeAPhoto});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      decoration: const BoxDecoration(
        color: ColorUtils.lightBackgroundSM,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 2),
          _topBorder(),
          const SizedBox(height: 24),
          _header(context),
          const SizedBox(height: 32),
          _noticeSection(context),
          const SizedBox(height: 12),
          _takePhotoButton(context),
          const SizedBox(height: 12),
          _accessLibraryButton(context),
        ],
      ),
    );
  }

  Widget _topBorder() {
    return Container(
      height: 4,
      width: 72,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
      ),
    );
  }

  Widget _header(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Text(
            localization.recent,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }

  Widget _noticeSection(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ColorUtils.backgroundNotice,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.error, color: ColorUtils.primaryColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              localization.limitedAccessToPhotos,
              style: TextStyle(fontSize: 14),
            ),
          ),
          TextButton(
            onPressed: () {
              // TODO: Navigate to Manage permissions
            },
            child: Text(
              localization.manage,
              style: TextStyle(
                color: ColorUtils.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _takePhotoButton(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.withAlpha(127), width: 1),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
        onPressed: () {
          Navigator.pop(context);
          onTakeAPhoto();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization.takeAPhoto,
              style: TextStyle(color: Colors.black),
            ),
            SvgPicture.asset(
              'assets/images/ic_camera_black.svg',
              width: 21,
              height: 21,
            ),
          ],
        ),
      ),
    );
  }

  Widget _accessLibraryButton(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.withAlpha(127), width: 1),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        ),
        onPressed: () {
          onSelectImage('library_selected_image_url');
          Navigator.of(context).pop();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization.accessToMyLibrary,
              style: TextStyle(color: Colors.black),
            ),
            SvgPicture.asset(
              'assets/images/ic_photos_black.svg',
              width: 21,
              height: 21,
            ),
          ],
        ),
      ),
    );
  }
}
