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
    final selectedFrontSide = ref.read(selectedCardFrontSide.notifier).state;
    print(selectedFrontSide);
    if (controller.formKey.currentState!.validate() &&
        selectedFrontSide != null) {
      final selectedLogo = fileNameGetter(ref.read(selectedShopLogo));
      final selectedFront = fileNameGetter(ref.read(selectedCardFrontSide));
      final selectedBack = fileNameGetter(ref.read(selectedCardBackSide));
      await ref
          .read(createDiscountCardProvider.notifier)
          .createCard(controller, selectedLogo, selectedFront!, selectedBack);
      if (mounted) {
        showSnackBar('Card added successfully!');
      } else {
        showSnackBar('Something went wrong!');
      }
    } else {
      showSnackBar('Something went wrong!');
    }
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
      body: AddCardForm(controllers: controller, onButtonPressed: addCard),
    );
  }
}
