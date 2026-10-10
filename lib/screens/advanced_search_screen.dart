import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../service_detail_screen.dart';

class AdvancedSearchScreen extends StatefulWidget {
  const AdvancedSearchScreen({super.key});

  @override
  State<AdvancedSearchScreen> createState() =>
      _AdvancedSearchScreenState();
}

class _AdvancedSearchScreenState
    extends State<AdvancedSearchScreen> {
  final TextEditingController _searchController =
  TextEditingController();

  Timer? _debounceTimer;

  bool _isSearching = false;
  bool _hasSearched = false;

  List<SearchItem> _results = [];

  // Temporary dummy data.
  // Later this will come from PHP API.
  final List<SearchItem> _allServices = [
    SearchItem(
      id: 1,
      title: 'Makeup Artist',
      subtitle: 'Beauty & Makeup',
      icon: Icons.face_retouching_natural,
      keywords: [
        'makeup',
        'artist',
        'beauty',
        'make',
      ],
    ),
    SearchItem(
      id: 2,
      title: 'Makeup Designer',
      subtitle: 'Professional Makeup',
      icon: Icons.brush_outlined,
      keywords: [
        'makeup',
        'designer',
        'beauty',
        'make',
      ],
    ),
    SearchItem(
      id: 3,
      title: 'Bridal Makeup Artist',
      subtitle: 'Bridal & Wedding Makeup',
      icon: Icons.favorite_border_rounded,
      keywords: [
        'makeup',
        'bridal',
        'wedding',
        'bride',
      ],
    ),
    SearchItem(
      id: 4,
      title: 'Party Makeup Artist',
      subtitle: 'Party & Event Makeup',
      icon: Icons.celebration_outlined,
      keywords: [
        'makeup',
        'party',
        'event',
      ],
    ),
    SearchItem(
      id: 5,
      title: 'Makeup & Hair Artist',
      subtitle: 'Makeup + Hairstyling',
      icon: Icons.content_cut_outlined,
      keywords: [
        'makeup',
        'hair',
        'hairstyle',
        'beauty',
      ],
    ),
    SearchItem(
      id: 6,
      title: 'Photographer',
      subtitle: 'Photography & Events',
      icon: Icons.camera_alt_outlined,
      keywords: [
        'photo',
        'photographer',
        'photography',
      ],
    ),
    SearchItem(
      id: 7,
      title: 'Wedding Photographer',
      subtitle: 'Wedding & Pre-Wedding',
      icon: Icons.photo_camera_outlined,
      keywords: [
        'wedding',
        'photo',
        'photographer',
      ],
    ),
    SearchItem(
      id: 8,
      title: 'Interior Designer',
      subtitle: 'Home & Interior',
      icon: Icons.design_services_outlined,
      keywords: [
        'interior',
        'designer',
        'design',
        'home',
      ],
    ),
    SearchItem(
      id: 9,
      title: 'Furniture Designer',
      subtitle: 'Furniture & Woodwork',
      icon: Icons.chair_outlined,
      keywords: [
        'furniture',
        'designer',
        'wood',
      ],
    ),
    SearchItem(
      id: 10,
      title: 'Electrician',
      subtitle: 'Electrical Services',
      icon: Icons.electrical_services_outlined,
      keywords: [
        'electric',
        'electrician',
        'electrical',
      ],
    ),
    SearchItem(
      id: 11,
      title: 'Plumber',
      subtitle: 'Plumbing Services',
      icon: Icons.plumbing_outlined,
      keywords: [
        'plumber',
        'plumbing',
      ],
    ),
    SearchItem(
      id: 12,
      title: 'Carpenter',
      subtitle: 'Furniture & Woodwork',
      icon: Icons.handyman_outlined,
      keywords: [
        'carpenter',
        'wood',
        'furniture',
      ],
    ),
  ];

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounceTimer?.cancel();

    final query = value.trim().toLowerCase();

    setState(() {
      _hasSearched = false;
      _isSearching = false;
    });

    // Don't search until 4 characters.
    if (query.length < 4) {
      setState(() {
        _results = [];
      });
      return;
    }

    // Debounce search.
    _debounceTimer = Timer(
      const Duration(milliseconds: 400),
          () {
        _performSearch(query);
      },
    );
  }

  Future<void> _performSearch(String query) async {
    if (!mounted) return;

    setState(() {
      _isSearching = true;
      _hasSearched = true;
    });

    // ---------------------------------------------------
    // TEMPORARY LOCAL SEARCH
    // ---------------------------------------------------
    //
    // Later replace this with:
    //
    // final response = await ApiService.post(
    //   '/service/search',
    //   {'keyword': query},
    // );
    //
    // ---------------------------------------------------

    await Future.delayed(
      const Duration(milliseconds: 250),
    );

    final words = query
        .split(' ')
        .where((e) => e.isNotEmpty)
        .toList();

    final matched = _allServices.where((service) {
      final searchableText = [
        service.title,
        service.subtitle,
        ...service.keywords,
      ].join(' ').toLowerCase();

      return words.every(
            (word) => searchableText.contains(word),
      );
    }).toList();

    if (!mounted) return;

    setState(() {
      _results = matched;
      _isSearching = false;
    });
  }

  void _clearSearch() {
    _debounceTimer?.cancel();

    _searchController.clear();

    setState(() {
      _results = [];
      _hasSearched = false;
      _isSearching = false;
    });
  }

  void _selectService(SearchItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServiceDetailScreen(
          serviceName: item.title,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ------------------------------------------------
            // SEARCH HEADER
            // ------------------------------------------------
            Padding(
              padding: const EdgeInsets.fromLTRB(
                12,
                12,
                20,
                12,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F5F7),
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        textInputAction:
                        TextInputAction.search,
                        onChanged: _onSearchChanged,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppTheme.greyText,
                          ),
                          hintText:
                          'Search services...',
                          hintStyle: const TextStyle(
                            color: AppTheme.greyText,
                          ),
                          suffixIcon: query.isNotEmpty
                              ? IconButton(
                            onPressed:
                            _clearSearch,
                            icon: const Icon(
                              Icons.close_rounded,
                            ),
                          )
                              : null,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ------------------------------------------------
            // CONTENT
            // ------------------------------------------------
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    final query = _searchController.text.trim();

    // Before user enters 4 characters.
    if (query.length < 4) {
      return _buildInitialState();
    }

    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppTheme.primary,
        ),
      );
    }

    if (_hasSearched && _results.isEmpty) {
      return _buildNoResults();
    }

    return _buildSearchResults();
  }

  Widget _buildInitialState() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        22,
        20,
        22,
        30,
      ),
      children: [
        const Text(
          'What are you looking for?',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Search for a service, professional or category.',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.greyText,
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          'Popular searches',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 15),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _searchChip('Makeup Artist'),
            _searchChip('Photographer'),
            _searchChip('Carpenter'),
            _searchChip('Interior Designer'),
            _searchChip('Electrician'),
            _searchChip('Plumber'),
            _searchChip('Cleaning'),
          ],
        ),

        const SizedBox(height: 35),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFEAF1FF),
                Color(0xFFF7EEFF),
              ],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                color: AppTheme.primary,
                size: 28,
              ),
              SizedBox(width: 13),
              Expanded(
                child: Text(
                  'Type at least 4 characters to start searching.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchChip(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text;
        _onSearchChanged(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F8),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        22,
        10,
        22,
        30,
      ),
      children: [
        Row(
          children: [
            const Text(
              'Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              '${_results.length} results',
              style: const TextStyle(
                color: AppTheme.greyText,
                fontSize: 13,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        ..._results.map(
              (item) => _SearchResultCard(
            item: item,
            onTap: () => _selectService(item),
          ),
        ),
      ],
    );
  }

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F7),
                borderRadius:
                BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.search_off_rounded,
                size: 38,
                color: AppTheme.greyText,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No services found',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Try searching for something else.',
              style: const TextStyle(
                color: AppTheme.greyText,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            OutlinedButton(
              onPressed: _clearSearch,
              child: const Text(
                'Clear Search',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultCard extends StatelessWidget {
  final SearchItem item;
  final VoidCallback onTap;

  const _SearchResultCard({
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 10,
        ),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFE9EBEF),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                borderRadius:
                BorderRadius.circular(17),
              ),
              child: Icon(
                item.icon,
                color: AppTheme.primary,
                size: 27,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.greyText,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: AppTheme.greyText,
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItem {
  final int id;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> keywords;

  const SearchItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.keywords,
  });
}