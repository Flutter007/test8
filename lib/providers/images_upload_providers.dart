import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedShopLogo = StateProvider<File?>((ref) => null);
final selectedCardFrontSide = StateProvider<File?>((ref) => null);
final selectedCardBackSide = StateProvider<File?>((ref) => null);
