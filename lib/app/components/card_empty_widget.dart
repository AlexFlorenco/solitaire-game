import 'package:flutter/material.dart';

class CardEmptyWidget extends StatelessWidget {
  final IconData? _icon;
  final String? _letter;
  final bool _back;

  const CardEmptyWidget.ace({super.key})
      : _icon = null,
        _letter = 'A',
        _back = false;

  const CardEmptyWidget.restart({super.key})
      : _icon = Icons.refresh,
        _letter = null,
        _back = false;

  const CardEmptyWidget.back({super.key})
      : _icon = null,
        _letter = null,
        _back = true;

  const CardEmptyWidget({super.key})
      : _icon = null,
        _letter = null,
        _back = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 50,
        height: 78,
        decoration: BoxDecoration(
          color: _back ? Colors.blue : Colors.black26,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: _back ? 2 : 1,
            strokeAlign: BorderSide.strokeAlignInside,
            color: _back ? Colors.white : Colors.grey[200]!,
          ),
        ),
        child: _icon != null
            ? Center(
                child: Icon(
                  _icon,
                  size: 32,
                  color: Colors.white54,
                ),
              )
            : _letter != null
                ? Center(
                    child: Text(
                      _letter,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
      ),
    );
  }
}
