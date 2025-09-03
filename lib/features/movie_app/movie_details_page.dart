import 'package:flutter/material.dart';
import 'movie_service.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  MovieDetails? movie;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadMovieDetails();
  }

  Future<void> loadMovieDetails() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });
      
      final movieDetails = await MovieService.getMovieDetails(widget.movieId);
      setState(() {
        movie = movieDetails;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.red),
            )
          : error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 64),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load movie details',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: loadMovieDetails,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 300,
                      pinned: true,
                      backgroundColor: Colors.black,
                      iconTheme: const IconThemeData(color: Colors.white),
                      title: const Text(
                        'TMDB Movies',
                        style: TextStyle(color: Colors.white),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              movie!.fullBackdropUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[800],
                                  child: const Icon(
                                    Icons.movie,
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                );
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie!.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (movie!.tagline.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                movie!.tagline,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie!.voteAverage.toStringAsFixed(1),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                if (movie!.runtime > 0)
                                  Text(
                                    '${movie!.runtime} min',
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                                const SizedBox(width: 16),
                                if (movie!.releaseDate.isNotEmpty)
                                  Text(
                                    movie!.releaseDate.substring(0, 4),
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                  ),
                              ],
                            ),
                            if (movie!.genres.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                children: movie!.genres.map((genre) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      genre,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                            const SizedBox(height: 24),
                            const Text(
                              'Overview',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              movie!.overview.isNotEmpty 
                                  ? movie!.overview 
                                  : 'No overview available.',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontSize: 16,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 32),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Play feature not implemented'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                icon: const Icon(Icons.play_arrow, color: Colors.white),
                                label: const Text(
                                  'Play',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
