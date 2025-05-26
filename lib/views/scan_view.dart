import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';
import '../utils/color_utils.dart';
import '../widgets/popup_gallery.dart';
import '../widgets/show_custom_toast.dart';
import '../widgets/custom_gallery_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/popup_scan_service_before.dart';
import 'package:provider/provider.dart';
import '../provider/customer_provider.dart';
import '../provider/tabbar_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/api_scan_service.dart';
import '../storage/customer_scan_storage.dart';

class ScanView extends StatefulWidget {
  const ScanView({Key? key}) : super(key: key);

  @override
  _ScanViewState createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late ARKitController arkitController;
  ARKitNode? node;

  bool showMesh = true;
  bool useWorldTracking = false;
  bool isLoading = true;

  final GlobalKey _repaintKey = GlobalKey();
  File? _selectedImage;

  void _showScanBeforeDialog() {
    showDialog(
      context: context,
      builder: (context) => ScanBeforeDialog(
        onOptionSelected: (option) {
          print('Selected option: $option');
          final localization = AppLocalizations.of(context)!;

          if (option == "No") {
            final customerProvider =
                Provider.of<CustomerProvider>(context, listen: false);
            if (customerProvider.isReturningFromHistory) {
              print('Selected option: $option 2');
              customerProvider.setIsReturningFromHistory(false);
              Navigator.pop(context);
            }
          } else if (option == localization.alreadyScanBefore) {
            print('Scan Success ==>> 001 ');

            // Navigator.pop(context);
          } else {
            print('Do nothing');
          }
        },
        onSuccess: (option) async {
          print('Scan Success ==>> 002');

          final ApiScanService apiScanService = ApiScanService();

          print('_selectedImage ==>> ${_selectedImage}');
          if (_selectedImage == null) {
            print("Lỗi: _selectedImage là null, không thể upload");
            return;
          }
          File imageFile = File(_selectedImage!.path);

          Provider.of<CustomerProvider>(context, listen: false)
              .setHasScanned(true);

          final result = await apiScanService.uploadSkinAnalysis(
            imageFile: imageFile,
            additionalInfo: 'Captured from mobile app',
          );

          if (result != null) {
            await CustomerScanStorage().saveScan(result);
            print('✅ Đã lưu CustomerScanModel local');
          }

          // Sau khi API xong thì mới pop và đổi tab
          Navigator.of(context).popUntil((route) => route.isFirst);

          final tabProvider = Provider.of<TabProvider>(context, listen: false);
          tabProvider.setTab(2);
        },
        initialOption: 'No',
      ),
    );
  }

  @override
  void dispose() {
    arkitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorUtils.lightBackgroundSM,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            final customerProvider =
                Provider.of<CustomerProvider>(context, listen: false);
            if (customerProvider.isReturningFromHistory) {
              customerProvider.setIsReturningFromHistory(false);
              Navigator.pop(context); // Quay về ScanHistoryView
            } else {
              // Quay về tab cũ
              final tabProvider =
                  Provider.of<TabProvider>(context, listen: false);
              tabProvider.setTab(0);
              customerProvider.setShowTabBar(true);
            }
          },
        ),
        title: Container(
          height: 42,
          width: 162,
          decoration: BoxDecoration(
            color: ColorUtils.lightBackgroundSM,
            border: Border.all(
              color: ColorUtils.backgroundSM.shade200,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(21),
          ),
          child: Center(
            child: Text(
              localization.facialAnalysis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorUtils.primaryColor,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : RepaintBoundary(
                        key: _repaintKey,
                        child: ARKitSceneView(
                          key: ValueKey(useWorldTracking),
                          configuration: useWorldTracking
                              ? ARKitConfiguration.worldTracking
                              : ARKitConfiguration.faceTracking,
                          onARKitViewCreated: onARKitViewCreated,
                        ),
                      ),
                if (isLoading)
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorUtils.primaryColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Bottom buttons section
          Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 40, left: 40, right: 40),
            color: ColorUtils.lightBackgroundSM,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton(
                  child: SvgPicture.asset(
                    'assets/images/ic_photos.svg',
                    width: 21,
                    height: 21,
                  ),
                  onPressed: () => _popupGallery(context),
                ),
                _buildButtonCamera(),
                _buildButton(
                  child: SvgPicture.asset(
                    'assets/images/ic_camera_rotate.svg',
                    width: 21,
                    height: 21,
                  ),
                  onPressed: () {
                    setState(() {
                      useWorldTracking = !useWorldTracking;
                      _selectedImage = null;
                      showMesh = !useWorldTracking;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonCamera() {
    return Container(
      width: 74,
      height: 74,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ColorUtils.cameraBgColor,
        border: Border.all(
          color: ColorUtils.backgroundSM.shade200,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorUtils.backgroundSM.shade200.withAlpha(76),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: GestureDetector(
          onTap: _takePicture,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: ColorUtils.primaryColor,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/images/ic_camera.svg',
              width: 33,
              height: 26,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required Widget child,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorUtils.backgroundSM.shade200,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorUtils.backgroundSM.shade200.withAlpha(76),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: ColorUtils.cameraBgColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: child,
      ),
    );
  }

  void onARKitViewCreated(ARKitController controller) async {
    arkitController = controller;

    if (!useWorldTracking) {
      arkitController.onAddNodeForAnchor = _handleAddAnchor;
      arkitController.onUpdateNodeForAnchor = _handleUpdateAnchor;
    }

    await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      isLoading = false;
    });
  }

  void _handleAddAnchor(ARKitAnchor anchor) {
    if (!(anchor is ARKitFaceAnchor)) return;

    if (!showMesh) return;

    final material = ARKitMaterial(fillMode: ARKitFillMode.lines);
    anchor.geometry.materials.value = [material];

    node = ARKitNode(geometry: anchor.geometry);
    arkitController.add(node!, parentNodeName: anchor.nodeName);
  }

  void _handleUpdateAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitFaceAnchor && mounted && node != null && showMesh) {
      arkitController.updateFaceGeometry(node!, anchor.identifier);
    }
  }

  Future<void> _takePicture() async {
    if (_selectedImage != null) {
      setState(() {
        _selectedImage = null;
        showMesh = !useWorldTracking;
      });
      return;
    }

    setState(() {
      showMesh = false;
    });

    await Future.delayed(Duration(milliseconds: 500));

    try {
      RenderRepaintBoundary boundary = _repaintKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      final buffer = byteData!.buffer;
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/snapshot.png');
      await file.writeAsBytes(buffer.asUint8List());

      print('Saved to: ${file.path}');
      setState(() {
        _selectedImage = file;
        showMesh = !useWorldTracking;
      });

      showCustomToast(context, 'Đã chụp ảnh thành công!');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showScanBeforeDialog();
      });
    } catch (e) {
      print("Error capturing image: $e");
    }

    setState(() {
      showMesh = !useWorldTracking;
    });
  }

  void _popupGallery(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        return SizedBox(
          height: screenHeight * 0.5,
          child: PopupGallery(
            onSelectImage: (selectedImageUrl) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showGalleryGrid(context);
              });
            },
            onTakeAPhoto: () {
              Future.delayed(const Duration(milliseconds: 300), () {
                if (_selectedImage != null) {
                  _takePicture();
                } else {
                  Navigator.of(context).pop();
                }
              });
            },
          ),
        );
      },
    );
  }

  void _showGalleryGrid(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return PopupGalleryGrid(
          onSelectImage: (String imageUrl) async {
            if (imageUrl.isEmpty) return;

            try {
              final file = File(imageUrl);
              if (!await file.exists()) {
                print('Error selecting image');
                return;
              }

              setState(() {
                _selectedImage = file;
              });

              Future.delayed(const Duration(milliseconds: 300), () {
                _showScanBeforeDialog();
              });
            } catch (e) {
              print('Error selecting image: $e');
            }
          },
          onTakeAPhoto: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (_selectedImage != null) {
                _takePicture();
              } else {
                if (mounted) {
                  Navigator.of(context).pop();
                }
              }
            });
          },
        );
      },
    );
  }
}
