import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test8/providers/discount_card_provider.dart';
import 'package:test8/widgets/add_card_form/add_card_form.dart';
import '../providers/images_upload_providers.dart';
import '../widgets/add_card_form/add_card_form_controllers.dart';

class AddCardScreen extends ConsumerStatefulWidget {
  const AddCardScreen({super.key});

  @override
  ConsumerState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends ConsumerState<AddCardScreen> {
  final controller = AddCardFormControllers();

  void showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void addCard() async {
    final frontFile = ref.read(selectedCardFrontSide);
    final logoFile = ref.read(selectedShopLogo);
    final backFile = ref.read(selectedCardBackSide);

    if (controller.formKey.currentState!.validate() && frontFile != null) {
      final selectedLogo = fileNameGetter(logoFile);
      final selectedFront = fileNameGetter(frontFile);
      final selectedBack = fileNameGetter(backFile);

      try {
        await upload(frontFile, 'cards_front_side', selectedFront, ref);
      } catch (e) {
        showSnackBar('Error with uploading card front side');
        return;
      }
      try {
        await upload(logoFile, 'cards_logo', selectedLogo, ref);
      } catch (e) {
        showSnackBar('Error with uploading logo');
        return;
      }
      try {
        await upload(backFile, 'cards_back_side', selectedBack, ref);
      } catch (e) {
        showSnackBar('Error with uploading card back side');
        return;
      }

      await ref
          .read(createDiscountCardProvider.notifier)
          .createCard(controller, selectedLogo, selectedFront!, selectedBack);
      if (mounted) {
        clearFields();
      }
    } else {
      showSnackBar('Select all fields');
    }
  }

  void clearFields() {
    ref.read(selectedShopLogo.notifier).state = null;
    ref.read(selectedCardFrontSide.notifier).state = null;
    ref.read(selectedCardBackSide.notifier).state = null;
    controller.shopTitleController.clear();
    controller.notesController.clear();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkStatusOfAction() {
    ref.listen(createDiscountCardProvider, (prev, next) {
      next.whenOrNull(
        data: (d) {
          showSnackBar('Successfully added');
        },
        error: (e, stack) {
          showSnackBar('Something went wrong...');
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    checkStatusOfAction();
    return Scaffold(
      appBar: AppBar(title: Text('Add new card!')),
      body: SingleChildScrollView(
        child: AddCardForm(controllers: controller, onButtonPressed: addCard),
      ),
    );
  }
}
