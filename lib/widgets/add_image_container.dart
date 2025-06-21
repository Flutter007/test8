import 'package:flutter/material.dart';

class AddPhotoContainer extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function()? onButtonTap;

  const AddPhotoContainer({
    super.key,
    required this.icon,
    required this.label,
    required this.onButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.primary, width: 4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(Icons.add_a_photo, size: 100),
          ElevatedButton.icon(
            onPressed: onButtonTap,
            icon: Icon(icon),
            label: Text(label),
          ),
        ],
      ),
    );
  }
}
