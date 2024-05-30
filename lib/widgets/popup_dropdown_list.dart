import 'package:flutter/material.dart';

class PopupDropdownList<T> extends StatelessWidget {
  final T value;
  final ValueChanged<T?>? onChanged; // Change the parameter type to T?
  final List<DropdownMenuItem<T>> items;

  const PopupDropdownList({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color.fromARGB(255, 52, 120, 54),
        ),
        child: DropdownButton<T>(
          value: value,
          onChanged: onChanged,
          items: items,
        ),
      ),
    );
  }
}
