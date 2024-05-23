import 'package:flutter/material.dart';

class FlipableCard extends StatefulWidget {
  final String text;
  final bool isImposter;
  final bool isLocked;
  final bool isEliminated;
  final bool isRoundActive;
  final VoidCallback onFlip;
  final VoidCallback onImposterSelected;

  const FlipableCard({
    super.key,
    required this.text,
    required this.isImposter,
    required this.isLocked,
    required this.isEliminated,
    required this.isRoundActive,
    required this.onFlip,
    required this.onImposterSelected,
  });

  @override
  _FlipableCardState createState() => _FlipableCardState();
}

class _FlipableCardState extends State<FlipableCard> {
  bool _isFlipped = false;
  bool _isLocked = false;

  void _flipCard() {
    if (!_isLocked) {
      setState(() {
        _isFlipped = !_isFlipped;
        if (!_isFlipped) {
          _isLocked = true;
          widget.onFlip();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color bgColor = Colors.white;
    String cardText = 'Flip Me';

    if (_isFlipped) {
      cardText = widget.text;
      if (widget.isImposter) {
        bgColor = Colors.red;
      }
    } else if (_isLocked) {
      bgColor = Colors.grey;
      cardText = 'This Card is Locked 🔒';
    }

    return GestureDetector(
      onTap: _flipCard,
      child: Card(
        color: bgColor,
        child: Center(
          child: Text(
            cardText,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
