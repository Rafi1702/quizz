import 'package:flutter/material.dart';

class ErrorPlaceholder extends StatelessWidget {
  final String? errorMessage;
  final void Function()? onRefreshPressed;
  const ErrorPlaceholder({this.errorMessage, this.onRefreshPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.refresh_rounded,
          size: 80.0,
        ),
        Text(
          errorMessage ?? "",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onRefreshPressed,
          child: const Text('Refresh Data'),
        ),
      ],
    );
  }
}
