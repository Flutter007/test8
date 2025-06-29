import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test8/widgets/add_image_container.dart';

class ImagePickerField extends ConsumerStatefulWidget {
  final StateProvider<File?> imageProvider;
  final IconData icon;
  final String label;
  final ImageSource source;

  const ImagePickerField({
    super.key,
    required this.imageProvider,
    required this.icon,
    required this.label,
    required this.source,
  });

  @override
  ConsumerState createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends ConsumerState<ImagePickerField> {
  void pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final imagePicker = await picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (imagePicker == null) {
      return;
    }
    final image = File(imagePicker.path);

    ref.read(widget.imageProvider.notifier).state = image;
  }

  void clearPhoto() {
    ref.read(widget.imageProvider.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final image = ref.watch(widget.imageProvider);
    return image == null
        ? AddPhotoContainer(
          onButtonTap: () => pickImage(widget.source),
          icon: widget.icon,
          label: widget.label,
        )
        : LayoutBuilder(
          builder: (ctx, constraints) {
            final width = constraints.maxWidth;
            return SizedBox(
              width: width / 2,
              height: width / 2,
              child: Stack(
                children: [
                  Image.file(
                    image,
                    width: width,
                    height: width,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 3,
                    right: 3,
                    child: IconButton(
                      onPressed: clearPhoto,
                      icon: Icon(Icons.clear, color: theme.colorScheme.error),
                      style: IconButton.styleFrom(
                        backgroundColor: theme.primaryColor.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
  }
}
