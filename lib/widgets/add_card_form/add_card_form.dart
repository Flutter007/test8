import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test8/providers/discount_card_provider.dart';
import 'package:test8/providers/images_upload_providers.dart';
import 'package:test8/widgets/add_card_form/add_card_form_controllers.dart';
import 'package:test8/widgets/custom_text_form_field.dart';
import 'package:test8/widgets/image_picker_field.dart';
import '../center_indicator.dart';

class AddCardForm extends ConsumerStatefulWidget {
  final AddCardFormControllers controllers;
  final void Function() onButtonPressed;
  const AddCardForm({
    super.key,
    required this.controllers,
    required this.onButtonPressed,
  });

  @override
  ConsumerState createState() => _AddCardFormState();
}

class _AddCardFormState extends ConsumerState<AddCardForm> {
  @override
  Widget build(BuildContext context) {
    final cardAddingState = ref.watch(createDiscountCardProvider);
    return Form(
      key: widget.controllers.formKey,
      child: SafeArea(
        child: Column(
          children: [
            CustomTextFormField(
              labelText: 'Enter Shop Title',
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 3) {
                  return 'Please enter right shop title';
                }
                return null;
              },
              helperText: 'Example: Globus',
              controller: widget.controllers.shopTitleController,
            ),
            ImagePickerField(
              imageProvider: selectedShopLogo,
              icon: Icons.photo,
              label: 'Select Shop Logo',
              source: ImageSource.gallery,
            ),
            SizedBox(height: 20),
            ImagePickerField(
              imageProvider: selectedCardFrontSide,
              icon: Icons.camera_alt,
              label: 'Take a photo of the card front side',
              source: ImageSource.camera,
            ),
            SizedBox(height: 20),
            ImagePickerField(
              imageProvider: selectedCardBackSide,
              icon: Icons.camera_alt,
              label: 'Take a photo of the card back side',
              source: ImageSource.camera,
            ),
            CustomTextFormField(
              labelText: 'Enter Notes',
              validator: null,
              helperText: 'Not required',
              controller: widget.controllers.notesController,
            ),
            ElevatedButton.icon(
              onPressed:
                  cardAddingState.isLoading ? null : widget.onButtonPressed,
              icon: Icon(Icons.add),
              label:
                  cardAddingState.isLoading
                      ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Loading...'),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: CenterIndicator(),
                          ),
                        ],
                      )
                      : Text('Add Card!'),
            ),
          ],
        ),
      ),
    );
  }
}
