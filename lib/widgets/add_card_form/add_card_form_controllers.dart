import 'package:flutter/material.dart';

class AddCardFormControllers {
  final formKey = GlobalKey<FormState>();
  final shopTitleController = TextEditingController();
  final notesController = TextEditingController();

  void dispose() {
    shopTitleController.dispose();
    notesController.dispose();
  }
}
