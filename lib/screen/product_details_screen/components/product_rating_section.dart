import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductRatingSection extends StatelessWidget {
  const ProductRatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RatingBar.builder(
          initialRating: 2.2,
          direction: Axis.horizontal,
          itemSize: 20,
          itemBuilder: (_, __) => const FaIcon(
            FontAwesomeIcons.solidStar,
            color: Colors.amber,
          ),
          onRatingUpdate: (_) {},
        ),
        const SizedBox(height: 10),
        Text(
          "(12 Reviews)",
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.w300,fontSize: 12
          ),
        )
      ],
    );
  }
}
