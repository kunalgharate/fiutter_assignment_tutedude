import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pokemon_service.dart';
import 'pokemon_details_page.dart';

class PokemonListPage extends StatefulWidget {
  final String trainerName;

  const PokemonListPage({Key? key, required this.trainerName}) : super(key: key);

  @override
  State<PokemonListPage> createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  List<Pokemon> pokemonList = [];
  bool isLoading = true;
  String? error;
  final TextEditingController _searchController = TextEditingController();
  List<Pokemon> filteredPokemon = [];
  bool isDarkMode = false;
  Set<int> favoritePokemon = {};

  @override
  void initState() {
    super.initState();
    loadPokemon();
  }

  Future<void> loadPokemon() async {
    try {
      setState(() {
        isLoading = true;
        error = null;
      });

      final pokemon = await PokemonService.getPokemonList(limit: 50);
      setState(() {
        pokemonList = pokemon;
        filteredPokemon = pokemon;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString().contains('Failed to host lookup') || 
               e.toString().contains('Network is unreachable') ||
               e.toString().contains('No address associated')
            ? 'No internet connection. Please check your network and try again.'
            : e.toString();
        isLoading = false;
      });
    }
  }

  void _filterPokemon(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredPokemon = pokemonList;
      } else {
        filteredPokemon = pokemonList
            .where((pokemon) =>
                pokemon.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      case 'grass':
        return Colors.green;
      case 'electric':
        return Colors.yellow[700]!;
      case 'psychic':
        return Colors.pink;
      case 'ice':
        return Colors.cyan;
      case 'dragon':
        return Colors.indigo;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pink[200]!;
      case 'fighting':
        return Colors.red[800]!;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.orange[800]!;
      case 'flying':
        return Colors.blue[300]!;
      case 'bug':
        return Colors.green[400]!;
      case 'rock':
        return Colors.grey[600]!;
      case 'ghost':
        return Colors.purple[300]!;
      case 'steel':
        return Colors.grey;
      case 'normal':
        return Colors.grey[400]!;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Poképedia',
              style: GoogleFonts.orbitron(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Welcome, ${widget.trainerName}!',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF3B82F6),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              _showFavorites();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF3B82F6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterPokemon,
              decoration: InputDecoration(
                hintText: 'Search Pokémon...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.white,
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TweenAnimationBuilder(
                          tween: Tween<double>(begin: 0, end: 1),
                          duration: const Duration(seconds: 2),
                          builder: (context, double value, child) {
                            return Transform.rotate(
                              angle: value * 6.28,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF3B82F6),
                                      const Color(0xFF3B82F6).withOpacity(0.3),
                                    ],
                                  ),
                                ),
                                child: const Icon(
                                  Icons.catching_pokemon,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Loading Pokémon...',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 64,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load Pokémon',
                              style: GoogleFonts.poppins(fontSize: 18),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: loadPokemon,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: loadPokemon,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(16),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: filteredPokemon.length,
                          itemBuilder: (context, index) {
                            final pokemon = filteredPokemon[index];
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300 + (index * 50)),
                              curve: Curves.easeOutBack,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          PokemonDetailsPage(pokemon: pokemon),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: animation.drive(
                                            Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                                                .chain(CurveTween(curve: Curves.easeInOut)),
                                          ),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: 'pokemon-${pokemon.id}',
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isDarkMode ? Colors.grey[850] : Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: _getTypeColor(pokemon.types.first).withOpacity(0.3),
                                          blurRadius: 12,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  _getTypeColor(pokemon.types.first).withOpacity(0.3),
                                                  _getTypeColor(pokemon.types.first).withOpacity(0.1),
                                                ],
                                              ),
                                              borderRadius: const BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                              ),
                                            ),
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: pokemon.imageUrl.isNotEmpty
                                                      ? Image.network(
                                                          pokemon.imageUrl,
                                                          fit: BoxFit.contain,
                                                          loadingBuilder: (context, child, loadingProgress) {
                                                            if (loadingProgress == null) return child;
                                                            return CircularProgressIndicator(
                                                              color: _getTypeColor(pokemon.types.first),
                                                              strokeWidth: 2,
                                                            );
                                                          },
                                                          errorBuilder: (context, error, stackTrace) {
                                                            return const Icon(
                                                              Icons.catching_pokemon,
                                                              size: 64,
                                                              color: Colors.grey,
                                                            );
                                                          },
                                                        )
                                                      : const Icon(
                                                          Icons.catching_pokemon,
                                                          size: 64,
                                                          color: Colors.grey,
                                                        ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  left: 8,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (favoritePokemon.contains(pokemon.id)) {
                                                          favoritePokemon.remove(pokemon.id);
                                                        } else {
                                                          favoritePokemon.add(pokemon.id);
                                                        }
                                                      });
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets.all(4),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white.withOpacity(0.9),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        favoritePokemon.contains(pokemon.id)
                                                            ? Icons.favorite
                                                            : Icons.favorite_border,
                                                        color: Colors.red,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black.withOpacity(0.7),
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Text(
                                                      '#${pokemon.id.toString().padLeft(3, '0')}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Column(
                                              children: [
                                                Text(
                                                  pokemon.capitalizedName,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Wrap(
                                                  spacing: 4,
                                                  children: pokemon.types.take(2).map((type) {
                                                    return Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: _getTypeColor(type),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Text(
                                                        type,
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 9,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  void _showFavorites() {
    final favorites = pokemonList.where((p) => favoritePokemon.contains(p.id)).toList();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? Colors.grey[850] : Colors.white,
        title: Text(
          'Favorite Pokémon (${favorites.length})',
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: favorites.isEmpty
              ? Center(
                  child: Text(
                    'No favorites yet!\nTap ♡ on Pokémon cards to add them.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                  ),
                )
              : ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final pokemon = favorites[index];
                    return ListTile(
                      leading: pokemon.imageUrl.isNotEmpty
                          ? Image.network(pokemon.imageUrl, width: 40, height: 40)
                          : const Icon(Icons.catching_pokemon),
                      title: Text(
                        pokemon.capitalizedName,
                        style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                      ),
                      subtitle: Text(
                        '#${pokemon.id.toString().padLeft(3, '0')}',
                        style: TextStyle(color: isDarkMode ? Colors.grey[400] : Colors.grey[600]),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PokemonDetailsPage(pokemon: pokemon),
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
