import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PopupGalleryGrid extends StatefulWidget {
  final Function(String) onSelectImage;
  final Function() onTakeAPhoto;

  const PopupGalleryGrid(
      {super.key, required this.onSelectImage, required this.onTakeAPhoto});

  @override
  State<PopupGalleryGrid> createState() => _PopupGalleryGridState();
}

class _PopupGalleryGridState extends State<PopupGalleryGrid> {
  List<AssetEntity> _photos = [];

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final PermissionState permission =
        await PhotoManager.requestPermissionExtend();
    if (!permission.isAuth) return;

    final albums = await PhotoManager.getAssetPathList(type: RequestType.image);
    final recentAlbum = albums.first;

    List<AssetEntity> allPhotos = [];
    int page = 0;
    const pageSize = 100;

    while (true) {
      final photos =
          await recentAlbum.getAssetListPaged(page: page, size: pageSize);
      if (photos.isEmpty) break;

      allPhotos.addAll(photos);
      page++;
    }

    setState(() {
      _photos = allPhotos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Column(
        children: [
          const SizedBox(height: 2),
          _topBorder(),
          const SizedBox(height: 24),
          _header(context),
          const SizedBox(height: 32),
          _accessLibraryButton(context),
          const SizedBox(height: 12),
          Expanded(child: _buildPhotoGrid(context)),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          widget.onSelectImage('library_selected_image_url');
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

  Widget _buildPhotoGrid(BuildContext context) {
    final totalItems = _photos.length + 1;
    return GridView.builder(
      itemCount: totalItems,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () {
              Navigator.pop(context);
              widget.onTakeAPhoto();
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey.shade700,
                  width: 1,
                ),
              ),
              child: const Center(
                child: Icon(Icons.camera_alt_outlined,
                    size: 30, color: Colors.black),
              ),
            ),
          );
        }

        final photo = _photos[index - 1];
        return FutureBuilder<Uint8List?>(
          future: photo.thumbnailDataWithSize(const ThumbnailSize(200, 200)),
          builder: (_, snapshot) {
            final bytes = snapshot.data;
            if (bytes == null) return const SizedBox.shrink();
            return GestureDetector(
              onTap: () async {
                final file = await photo.file;
                if (file != null) {
                  widget.onSelectImage(file.path);
                  Navigator.of(context).pop();
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.memory(bytes, fit: BoxFit.cover),
              ),
            );
          },
        );
      },
    );
  }
}
