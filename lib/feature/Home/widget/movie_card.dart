import 'package:flutter/material.dart';
import 'package:movie_app/core/constant.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final String titleOfMovie;
  final bool isVeritcal;
  const MovieCard(
      {super.key,
      this.isVeritcal = false,
      required this.posterPath,
      required this.titleOfMovie});

  @override
  Widget build(BuildContext context) {
    return isVeritcal
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 190,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    posterPath,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              SizedBox(
                  width: 150,
                  child: Text(
                    titleOfMovie,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Poppins'),
                  )),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 190,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    posterPath,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                  width: 150,
                  child: Text(
                    titleOfMovie,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'Poppins'),
                  )),
            ],
          );
  }
}
