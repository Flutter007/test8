import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test8/widgets/add_card_form/add_card_form_controllers.dart';
import 'package:test8/widgets/custom_text_form_field.dart';

class AddCardForm extends ConsumerStatefulWidget {
  final AddCardFormControllers controllers;
  const AddCardForm({super.key, required this.controllers});

  @override
  ConsumerState createState() => _AddCardFormState();
}

class _AddCardFormState extends ConsumerState<AddCardForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.controllers.formKey,
      child: SingleChildScrollView(
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
              controller: widget.controllers.shopTitleController,
            ),
          ],
        ),
      ),
    );
  }
}
